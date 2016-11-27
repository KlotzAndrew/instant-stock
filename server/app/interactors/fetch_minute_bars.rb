class FetchMinuteBars
  include Interactor

  DATA_SOURCE = 'yahoo_chart_api'.freeze

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
    fetcher        = Yafa::StockChart.new(stock.ticker)
    full_bars_data = fetcher.fetch
    bars           = full_bars_data['series']
    bars.each_with_object([]) do |bar, arr|
      arr << format_bar(bar)
    end
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
end
