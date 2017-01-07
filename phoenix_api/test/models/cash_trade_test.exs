defmodule PhoenixApi.CashTradeTest do
  use PhoenixApi.ModelCase

  alias PhoenixApi.CashTrade

  @valid_attrs %{cash_holding_id: 42, quantity: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = CashTrade.changeset(%CashTrade{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = CashTrade.changeset(%CashTrade{}, @invalid_attrs)
    refute changeset.valid?
  end
end
