defmodule PhoenixApi.StockTradeTest do
  use PhoenixApi.ModelCase

  alias PhoenixApi.StockTrade

  @valid_attrs %{enter_price: "120.5", exit_price: "120.5", exit_time: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, quantity: 42, stock_holding_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = StockTrade.changeset(%StockTrade{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = StockTrade.changeset(%StockTrade{}, @invalid_attrs)
    refute changeset.valid?
  end
end
