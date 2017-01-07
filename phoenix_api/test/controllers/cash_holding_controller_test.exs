defmodule PhoenixApi.CashHoldingControllerTest do
  use PhoenixApi.ConnCase

  alias PhoenixApi.CashHolding
  @valid_attrs %{currency: "some content", portfolio_id: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, cash_holding_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    cash_holding = Repo.insert! %CashHolding{}
    conn = get conn, cash_holding_path(conn, :show, cash_holding)
    assert json_response(conn, 200)["data"] == %{"id" => cash_holding.id,
      "currency" => cash_holding.currency,
      "portfolio_id" => cash_holding.portfolio_id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, cash_holding_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, cash_holding_path(conn, :create), cash_holding: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(CashHolding, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, cash_holding_path(conn, :create), cash_holding: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    cash_holding = Repo.insert! %CashHolding{}
    conn = put conn, cash_holding_path(conn, :update, cash_holding), cash_holding: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(CashHolding, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    cash_holding = Repo.insert! %CashHolding{}
    conn = put conn, cash_holding_path(conn, :update, cash_holding), cash_holding: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    cash_holding = Repo.insert! %CashHolding{}
    conn = delete conn, cash_holding_path(conn, :delete, cash_holding)
    assert response(conn, 204)
    refute Repo.get(CashHolding, cash_holding.id)
  end
end
