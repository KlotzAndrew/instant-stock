defmodule Commands.UpdateStockQuoteTest do
  use ExUnit.Case, async: true

  alias Commands.UpdateStockQuote

  defmodule Repo do
    def get_by(_stock, _ticker) do
      %{
        id: 888
      }
    end

    def insert!(_changeset) do
      send self(), :insert
    end
  end

  test "updates existing stock minute bar" do
    quote = [%{
      "Symbol" => "TSLA",
      "StockExchange" => "XYZ",
      "Name" => "Tesla!",
      "LastTradePriceOnly" => "123.45",
      "last_trade" => "TODO, use a real time"
    }]

    UpdateStockQuote.update(quote, Repo)

    assert_receive :insert
  end
end
