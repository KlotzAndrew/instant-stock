class FindPromoPortfolio
  include Interactor

  def call
    portfolio = find_promo_portfolio

    context.portfolio = portfolio
  end

  private

  def find_promo_portfolio
    Portfolio.find_by(promo_portfolio: true)
  end
end
