class PortfolioPositionUpdater
  def initialize(portfolio = promo_portfolio)
    @portfolio = portfolio
  end

  def update
    stocks = @portfolio.stocks
    quote_updater = CurrentQuotesUpdater.new(stocks)
    quote_updater.update

    # holding_updater = PortfolioHoldingUpdater.new(@portfolio)
    # holding_updater.update
  end

  private

  def promo_portfolio
    FindPromoPortfolio.call.portfolio
  end
end
