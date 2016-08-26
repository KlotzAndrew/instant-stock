class ReturnPromoPortfolio
  include Interactor::Organizer

  organize FindPromoPortfolio,
           FindPortfolioValue,
           GetAllHoldings,
           FindPortfolioMinuteValues
end
