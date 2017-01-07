defmodule PhoenixApi.CashTradeControllerTest do
  use PhoenixApi.ConnCase

  alias PhoenixApi.CashTrade
  @valid_attrs %{cash_holding_id: 42, quantity: "120.5"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, cash_trade_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    cash_trade = Repo.insert! %CashTrade{}
    conn = get conn, cash_trade_path(conn, :show, cash_trade)
    assert json_response(conn, 200)["data"] == %{"id" => cash_trade.id,
      "cash_holding_id" => cash_trade.cash_holding_id,
      "quantity" => cash_trade.quantity}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, cash_trade_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, cash_trade_path(conn, :create), cash_trade: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(CashTrade, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, cash_trade_path(conn, :create), cash_trade: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    cash_trade = Repo.insert! %CashTrade{}
    conn = put conn, cash_trade_path(conn, :update, cash_trade), cash_trade: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(CashTrade, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    cash_trade = Repo.insert! %CashTrade{}
    conn = put conn, cash_trade_path(conn, :update, cash_trade), cash_trade: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    cash_trade = Repo.insert! %CashTrade{}
    conn = delete conn, cash_trade_path(conn, :delete, cash_trade)
    assert response(conn, 204)
    refute Repo.get(CashTrade, cash_trade.id)
  end
end
