class FindPortfolioValue
  include Interactor

  def call
    portfolio = context.portfolio

    cash_value = find_cash_value portfolio
    stock_value = find_stock_value portfolio

    context.value = cash_value + stock_value
  end

  private

  def find_cash_value(portfolio)
    cash_holdings = portfolio.cash_holdings

    cash_holdings.reduce(0) do |sum, cash|
      sum + cash.amount
    end
  end

  def find_stock_value(portfolio)
    holdings = portfolio.holdings

    holdings.reduce(0) do |sum, holding|
      sum + find_holding_value(holding)
    end
  end

  def find_holding_value(holding)
    trades = holding.trades
    stock = holding.stock

    quantity = trades.reduce(0) do |sum, trade|
      sum + trade.quantity
    end

    quantity * stock.last_quote
  end
end
