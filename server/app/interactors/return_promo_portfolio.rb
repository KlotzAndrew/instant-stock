class ReturnPromoPortfolio
  include Interactor::Organizer

  organize FindPromoPortfolio,
           FindPortfolioValue,
           SerializeHoldingsAndTrades
end
