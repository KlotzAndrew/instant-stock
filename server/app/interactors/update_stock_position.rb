class UpdateStockPosition
  include Interactor::Organizer

  organize FindPromoPortfolio,
           FindPortfolioStocks,
           FetchStockQuotes
  # UpdateStocksFromQuote,
  # CalculatePositionChange,
  # PerformStockTrades
end
