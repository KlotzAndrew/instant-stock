defmodule ExecuteTradeTest do
  use ExUnit.Case, async: true

  alias Commands.ExecuteTrade

  defmodule Checker do
    def parse(string) do
      case string do
        "buy TSLA" ->
          true
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

  test "fetch when command" do
    ExecuteTrade.trade("buy TSLA", Checker, Fetcher)

    assert_receive :fetched
  end

  test "does not fetch when no command" do
    ExecuteTrade.trade("not a command", Checker, Fetcher)

    refute_receive :fetched
  end
end
