class ExecutePortfolioTrade
  include Interactor::Organizer

  organize CheckChatCommand,
           FetchStockQuotes,
           UpdateStockFromQuote,
           PerformStockTrade
end
