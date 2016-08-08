class FetchMinuteBars
  include Interactor

  YAHOO_CHART_API = 'http://chartapi.finance.yahoo.com/instrument/1.0/'\
                    'yahoo_ticker/chartdata;type=quote;range=1d/json'.freeze
  READ_TIMEOUT    = 5
  DATA_SOURCE     = 'yahoo_chart_api'.freeze

  def call
    stocks                    = context.stocks
    stock_minute_bars         = get_stock_minute_bars stocks
    context.stock_minute_bars = stock_minute_bars
  end

  private

  def get_stock_minute_bars(stocks)
    stocks.each_with_object([]) do |stock, arr|
      arr << stock_with_bars(stock)
    end
  end

  def stock_with_bars(stock)
    {
      stock_id:    stock.id,
      minute_bars: get_minute_bars(stock)
    }
  end

  def get_minute_bars(stock)
    full_bars_data = get_bars_data stock
    bars           = full_bars_data['series']
    bars.each_with_object([]) do |bar, arr|
      arr << format_bar(bar)
    end
  end

  def get_bars_data(stock)
    quote_data = call_api stock
    parse_quote quote_data
  end

  def format_bar(bar)
    {
      data_source:    DATA_SOURCE,
      quote_time:     Time.zone.at(bar['Timestamp']),
      high:           bar['high'],
      open:           bar['open'],
      close:          bar['close'],
      low:            bar['low'],
      adjusted_close: nil,
      volume:         bar['volume']
    }
  end

  def call_api(stock)
    begin
      url      = format_api_url stock.ticker
      response = perform_api_request url
    rescue Timeout::Error
      context.fail! # (message: GENERAL_ERROR_MESSAGE)
    end

    response.read
  end

  def perform_api_request(url)
    open(
      url,
      ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE,
      read_timeout:    READ_TIMEOUT
    )
  end

  def format_api_url(yahoo_ticker)
    YAHOO_CHART_API.sub('yahoo_ticker', yahoo_ticker)
  end

  def parse_quote(data)
    json_string = data.split json_regex_match
    JSON.parse json_string[1]
  end

  def json_regex_match
    /\(|\)/
  end
end
