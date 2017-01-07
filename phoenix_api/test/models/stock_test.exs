defmodule PhoenixApi.StockTest do
  use PhoenixApi.ModelCase

  alias PhoenixApi.Stock

  @valid_attrs %{currency: "some content", name: "some content", stock_exchange: "some content", ticker: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Stock.changeset(%Stock{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Stock.changeset(%Stock{}, @invalid_attrs)
    refute changeset.valid?
  end
end
