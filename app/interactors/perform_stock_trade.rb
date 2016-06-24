class PerformStockTrade
  include Interactor

  def call
    portfolio    = find_portfolio context.portfolio_id
    stocks       = context.stocks
    quantity     = context.quantity

    trades = complete_trades stocks, portfolio, quantity
    context.trades = trades
  end

  private

  def complete_trades(stocks, portfolio, quantity)
    stocks.map do |stock|
      complete_trade stock, portfolio, quantity
    end
  end

  def complete_trade(stock, portfolio, quantity)
    holding = find_or_create_holding stock, portfolio
    trade = create_trade holding, stock, quantity
  end

  def create_trade(holding, stock, quantity)
    Trade.create(
      holding_id:  holding.id,
      enter_price: stock.last_quote,
      quantity:    quantity
    )
  end

  def find_or_create_holding(stock, portfolio)
    Holding.find_or_create_by(
      stock_id: stock.id,
      portfolio_id: portfolio.id,
      active: true
    )
  end

  def find_portfolio(portfolio_id)
    Portfolio.find_by(id: portfolio_id)
  end
end
