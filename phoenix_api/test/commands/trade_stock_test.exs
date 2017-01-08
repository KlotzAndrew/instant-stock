defmodule TradeStockTest do
  use ExUnit.Case, async: true

  alias Commands.TradeStock

  defmodule Repo do
    def get(_portfolio, _id) do
      %{
        id: 123
      }
    end

    def all(query) do
      [%{
        id: 456,
        close: Decimal.new(10)
      }]
    end

    def get_by(_stock, _ticker) do
      %{
        id: 888,
        currency: "USD"
      }
    end

    def insert(_changeset) do
      send self(), :insert
    end

    def transaction(_func) do
      # TODO: yield?
    end
  end

  @tag :skip
  test "trades a stock" do
    portfolio_id = "88"
    command = %{
      quantity: "10",
      tickers: ["GOOG"]
    }
    quote = [%{
      "Symbol" => "TSLA",
      "StockExchange" => "XYZ",
      "Name" => "Tesla!",
      "LastTradePriceOnly" => "123.45",
      "last_trade" => "TODO, use a real time"
    }]

    TradeStock.trade(portfolio_id, command, Repo)

    assert_receive :insert
  end
end
