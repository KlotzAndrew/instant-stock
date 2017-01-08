defmodule ExecuteTradeTest do
  use ExUnit.Case, async: true

  alias Commands.ExecuteTrade

  defmodule Checker do
    def parse(string) do
      case string do
        "buy TSLA" ->
          %{tickers: ["TSLA"]}
        "not a command" ->
          false
      end
    end
  end

  defmodule Fetcher do
    def fetch(_string) do
      send self(), :fetched
    end
  end

  defmodule Quoter do
    def update(_quote) do
      send self(), :quoted
    end
  end

  defmodule Trader do
    def trade(_id, _command) do
      send self(), :traded
    end
  end

  test "fetch when command" do
    ExecuteTrade.trade("buy TSLA", "1", Checker, Fetcher, Quoter, Trader)

    assert_receive :fetched
    assert_receive :quoted
    assert_receive :traded
  end

  test "does not fetch when no command" do
    ExecuteTrade.trade("not a command", "1", Checker, Fetcher)

    refute_receive :fetched
  end
end
