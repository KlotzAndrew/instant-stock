class GetPortfolioStockHoldings
  include Interactor

  def call
    portfolio = Portfolio.find(context.portfolio_id)
    context.stock_holdings = portfolio.stock_holdings
  end
end
