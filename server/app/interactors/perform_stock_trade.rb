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
    stock_holding = find_or_create_stock_holding stock, portfolio
    cash_holding = find_or_create_cash_holding stock, portfolio
    trade = create_trade stock_holding, cash_holding, stock, portfolio, quantity
    trade
  end

  def create_trade(stock_holding, cash_holding, stock, portfolio, quantity)
    ActiveRecord::Base.transaction do
      amount = stock.last_quote * quantity
      StockTrade.create(
        stock_holding_id:  stock_holding.id,
        enter_price: stock.last_quote,
        quantity:    quantity
      )
      CashTrade.create(
        cash_holding_id: cash_holding.id,
        quantity:        amount * -1
      )
    end
  end

  def find_or_create_stock_holding(stock, portfolio)
    StockHolding.find_or_create_by(
      stock_id: stock.id,
      portfolio_id: portfolio.id,
      active: true
    )
  end

  def find_or_create_cash_holding(stock, portfolio)
    CashHolding.find_or_create_by(
      currency: stock.currency,
      portfolio_id: portfolio.id
    )
  end

  def find_portfolio(portfolio_id)
    Portfolio.find_by(id: portfolio_id)
  end
end
