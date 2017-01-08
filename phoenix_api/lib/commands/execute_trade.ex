defmodule Commands.ExecuteTrade do
  alias Commands.FetchQuotes
  alias Commands.CheckCommand

  def trade(string, parser \\ CheckCommand, fetcher \\ FetchQuotes) do

    command =  parser.parse(string)
    if command do
      fetcher.fetch(command.tickers)
      # make trade
    end
  end
end
