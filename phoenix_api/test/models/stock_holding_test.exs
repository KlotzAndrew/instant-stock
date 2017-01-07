defmodule PhoenixApi.StockHoldingTest do
  use PhoenixApi.ModelCase

  alias PhoenixApi.StockHolding

  @valid_attrs %{portfolio_id: 42, stock_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = StockHolding.changeset(%StockHolding{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = StockHolding.changeset(%StockHolding{}, @invalid_attrs)
    refute changeset.valid?
  end
end
