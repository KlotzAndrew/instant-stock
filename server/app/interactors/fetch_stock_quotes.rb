class FetchStockQuotes
  include Interactor

  GENERAL_ERROR_MESSAGE = 'Unable to fetch latest quotes!'.freeze
  DEFAULT_TIME_ZONE     = 'Eastern Time (US & Canada)'.freeze

  def call
    tickers        = context.tickers
    quotes         = fetch_quotes_from_api tickers
    context.quotes = quotes
  end

  private

  def fetch_quotes_from_api(tickers)
    begin
      fetcher    = Yafa::StockQuotes.new(tickers)
      quote_data = fetcher.fetch
    rescue Timeout::Error
      context.fail!(message: GENERAL_ERROR_MESSAGE)
    end

    format_quote_data(quote_data)
  end

  def format_quote_data(quote_data)
    quote_data.inject([]) do |stocks_array, stock_hash|
      stocks_array << build_quote(stock_hash) unless stock_hash['Name'].nil?
    end
  end

  def build_quote(stock_hash)
    {
      ticker:         stock_hash['symbol'],
      name:           stock_hash['Name'],
      last_price:     BigDecimal.new(stock_hash['LastTradePriceOnly']),
      last_trade:     format_last_trade_time(stock_hash),
      stock_exchange: stock_hash['StockExchange']
    }
  end

  def format_last_trade_time(stock_hash)
    d_m_y    = format_month_day_year(stock_hash)
    hrs_mins = format_hour_minute(stock_hash)
    date     = "#{hrs_mins} #{d_m_y}"

    Time.use_zone(DEFAULT_TIME_ZONE) { Time.zone.parse(date) }.iso8601
  end

  def format_month_day_year(stock_hash)
    m_d_y = stock_hash['LastTradeDate'].split('/')
    [m_d_y[1], m_d_y[0], m_d_y[2]].join('/')
  end

  def format_hour_minute(stock_hash)
    stock_hash['LastTradeWithTime'].split.first
  end
end
