defmodule Commands.ExecuteTrade do
  alias Commands.FetchQuotes
  alias Commands.CheckCommand
  alias Commands.UpdateStockQuote
  alias Commands.TradeStock

  def trade(string, portfolio_id, parser \\ CheckCommand, fetcher \\ FetchQuotes, quoter \\ UpdateStockQuote, trader \\ TradeStock) do
    command = parser.parse(string)
    if command do
      quotes = fetcher.fetch(command.tickers)
      quoter.update(quotes)

      trader.trade(portfolio_id, command)
    end
  end
end
