class GetPortfolioCashHoldings
  include Interactor

  def call
    portfolio = Portfolio.find(context.portfolio_id)
    context.cash_holdings = portfolio.cash_holdings
  end
end
