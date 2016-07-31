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
    trade = create_trade holding, stock, portfolio, quantity
    trade
  end

  def create_trade(holding, stock, portfolio, quantity)
    ActiveRecord::Base.transaction do
      StockTrade.create(
        stock_holding_id:  holding.id,
        enter_price: stock.last_quote,
        quantity:    quantity
      )
      currency = stock.currency
      amount = stock.last_quote * quantity
      portfolio.change_cash(amount, currency)
    end
  end

  def find_or_create_holding(stock, portfolio)
    StockHolding.find_or_create_by(
      stock_id: stock.id,
      portfolio_id: portfolio.id,
      active: true
    )
  end

  def find_portfolio(portfolio_id)
    Portfolio.find_by(id: portfolio_id)
  end
end
