class FindPortfolioStocks
  include Interactor

  def call
    stocks         = context.portfolio.stocks
    context.stocks = stocks
  end
end
