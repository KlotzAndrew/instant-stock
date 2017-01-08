defmodule FetchQuotesTest do
  use ExUnit.Case, async: true

  alias Commands.FetchQuotes

  defmodule ApiClient do
    def get!(_string) do
      %{
        body: "{\"query\": {\"results\": {\"quote\": " <>
        "{\"Name\": \"Alphabet Inc.\",\"LastTradePriceOnly\": \"789.91\"}}}}"
      }
    end
  end

  test "parse finds match for buy with quantity" do
    tickers = ["GOOG"]
    name = "Alphabet Inc."
    last_trade_price_only = "789.91"
    quotes = FetchQuotes.fetch(tickers, ApiClient)

    assert 1 === length(quotes)

    quote = Enum.at(quotes, 0)
    assert name === quote["Name"]
    assert last_trade_price_only === quote["LastTradePriceOnly"]
  end
end
