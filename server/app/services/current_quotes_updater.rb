class CurrentQuotesUpdater
  def initialize(stocks)
    @stocks = stocks
  end

  def update
    quotes = fetch_latest_quotes
    create_minute_bars(quotes)
  end

  private

  def fetch_latest_quotes
    tickers = @stocks.map(&:ticker)
    result = FetchStockQuotes.call tickers: tickers
    result.quotes
  end

  def create_minute_bars(quotes)
    quotes.each do |quote|
      create_minute_bar(quote)
    end
  end

  def create_minute_bar(quote)
    stock = Stock.where(ticker: quote[:ticker]).first
    return unless stock
    create_bar(stock, quote)
  end

  def create_bar(stock, quote)
    MinuteBar.create(
      stock_id:    stock.id,
      data_source: quote[:stock_exchange],
      close:       quote[:last_price],
      quote_time:  quote[:last_trade]
    )
  end
end
