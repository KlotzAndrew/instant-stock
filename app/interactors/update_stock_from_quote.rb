class UpdateStockFromQuote
  include Interactor

  def call
    quotes = context.quotes

    stocks = update_or_create_stocks quotes

    context.stocks = stocks
  end

  private

  def update_or_create_stocks(quotes)
    quotes.map do |quote|
      update_or_create_stock quote
    end
  end

  def update_or_create_stock(quote)
    stock = find_stock quote
    return create_stock(quote) if stock.blank?
    update_stock stock, quote
  end

  def update_stock(stock, quote)
    stock.update(
      last_quote:      quote[:last_price],
      last_quote_time: quote[:last_trade]
    )
    stock
  end

  def find_stock(quote)
    search_values = stock_search_values quote
    stock         = Stock.find_by(search_values)

    return nil if stock.blank?
    stock
  end

  def stock_search_values(quote)
    {
      ticker:         quote[:ticker],
      stock_exchange: quote[:stock_exchange]
    }
  end

  def create_stock(quote)
    mapped_values = map_quote_to_stock quote
    Stock.create mapped_values
  end

  def map_quote_to_stock(quote)
    {
      ticker:          quote[:ticker],
      stock_exchange:  quote[:stock_exchange],
      last_quote_time: quote[:last_trade],
      last_quote:      quote[:last_price],
      name:            quote[:name],
      currency:        CashHolding::USD
    }
  end
end
