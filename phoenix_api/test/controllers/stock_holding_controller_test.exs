defmodule PhoenixApi.StockHoldingControllerTest do
  use PhoenixApi.ConnCase

  alias PhoenixApi.StockHolding
  @valid_attrs %{portfolio_id: 42, stock_id: 42}
  @invalid_attrs %{stock_id: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, stock_holding_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    stock_holding = Repo.insert! %StockHolding{portfolio_id: 42, stock_id: 42}
    conn = get conn, stock_holding_path(conn, :show, stock_holding)
    assert json_response(conn, 200)["data"] == %{
      "id" => Integer.to_string(stock_holding.id),
      "attributes" => %{},
      "type" => "stock-holding"
    }
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, stock_holding_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, stock_holding_path(conn, :create), stock_holding: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(StockHolding, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, stock_holding_path(conn, :create), stock_holding: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    stock_holding = Repo.insert! %StockHolding{portfolio_id: 42, stock_id: 42}
    conn = put conn, stock_holding_path(conn, :update, stock_holding), stock_holding: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(StockHolding, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    stock_holding = Repo.insert! %StockHolding{portfolio_id: 42, stock_id: 42}
    conn = put conn, stock_holding_path(conn, :update, stock_holding), stock_holding: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    stock_holding = Repo.insert! %StockHolding{portfolio_id: 42, stock_id: 42}
    conn = delete conn, stock_holding_path(conn, :delete, stock_holding)
    assert response(conn, 204)
    refute Repo.get(StockHolding, stock_holding.id)
  end
end
