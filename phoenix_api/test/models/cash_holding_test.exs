defmodule PhoenixApi.CashHoldingTest do
  use PhoenixApi.ModelCase

  alias PhoenixApi.CashHolding

  @valid_attrs %{currency: "some content", portfolio_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = CashHolding.changeset(%CashHolding{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = CashHolding.changeset(%CashHolding{}, @invalid_attrs)
    refute changeset.valid?
  end
end
