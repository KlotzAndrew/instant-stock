class ExecutePortfolioTrade
  include Interactor

  def call
    message      = context['message']
    portfolio_id = context['portfolio_id']

    portfolio    = find_portfolio portfolio_id
    stock_ticker = check_for_trade message
    stock_tickers = build_ticker_message stock_ticker
    quote_result = FetchStockQuotes.call stock_tickers
    Rails.logger.info "QUOTE HERE => #{quote_result}"
    stock = find_or_create_stock quote_result.quotes[0]

    complete_trade stock, portfolio
  end

  private

  def complete_trade(stock, portfolio)
    holding = portfolio.holdings.where(active: true).where(stock_id: stock.id)[0]
    holding = create_holding stock, portfolio if holding.blank?
    create_trade holding, stock
  end

  def create_trade(holding, stock)
    Rails.logger.info "HOLDING => #{holding}"
    trade = Trade.new(
      quantity:    1,
      enter_price: stock.last_quote
    )
    holding.trades << trade
  end

  def create_holding(stock, portfolio)
    portfolio.stocks << stock
    portfolio.holdings.where(active: true).where(stock_id: stock.id)[0]
  end

  def find_or_create_stock(quote)
    stock = Stock.where(ticker: quote[:ticker]).where(stock_exchange: quote[:stock_exchange]).first
    Rails.logger.info "STOCK HERE => #{stock}"
    Rails.logger.info "STOCK BLANK? => #{stock.blank?}"
    return stock unless stock.blank?
    Stock.create(
      ticker:          quote[:ticker],
      stock_exchange:  quote[:stock_exchange],
      last_quote_time: quote[:last_trade],
      last_quote:      quote[:last_price],
      name:            quote[:name]
    )
  end

  def find_portfolio(portfolio_id)
    Portfolio.find_by(id: portfolio_id)
  end

  def check_for_trade(message)
    match = /(buy [A-Z]{1,6})/.match(message)
    Rails.logger.info "MESSAGE_MATCH = #{match}"
    context.fail!(message: 'OMG NO MATCH') if match.nil?
    stock_ticker = match.string[4..match.string.length-1]
    stock_ticker
  end

  def build_ticker_message(stock_ticker)
    { tickers: [stock_ticker ] }
  end

end
