defmodule PhoenixApi.StockTradeControllerTest do
  use PhoenixApi.ConnCase

  alias PhoenixApi.StockTrade
  @valid_attrs %{enter_price: "120.5", exit_price: "120.5", exit_time: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, quantity: 42, stock_holding_id: 42}
  @invalid_attrs %{stock_holding_id: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, stock_trade_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    stock_trade = Repo.insert! %StockTrade{
      enter_price: 120.5,
      exit_price: 120.5,
      exit_time: Ecto.DateTime.utc,
      quantity: 42,
      stock_holding_id: 42
    }
    conn = get conn, stock_trade_path(conn, :show, stock_trade)
    assert json_response(conn, 200)["data"] == %{
      "id" => Integer.to_string(stock_trade.id),
      "attributes" => %{},
      "type" => "stock-trade"
    }
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, stock_trade_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, stock_trade_path(conn, :create), stock_trade: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(StockTrade, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, stock_trade_path(conn, :create), stock_trade: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    stock_trade = Repo.insert! %StockTrade{
      enter_price: 120.5,
      exit_price: 120.5,
      exit_time: Ecto.DateTime.utc,
      quantity: 42,
      stock_holding_id: 42
    }
    conn = put conn, stock_trade_path(conn, :update, stock_trade), stock_trade: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(StockTrade, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    stock_trade = Repo.insert! %StockTrade{
      enter_price: 120.5,
      exit_price: 120.5,
      exit_time: Ecto.DateTime.utc,
      quantity: 42,
      stock_holding_id: 42
    }
    conn = put conn, stock_trade_path(conn, :update, stock_trade), stock_trade: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    stock_trade = Repo.insert! %StockTrade{
      enter_price: 120.5,
      exit_price: 120.5,
      exit_time: Ecto.DateTime.utc,
      quantity: 42,
      stock_holding_id: 42
    }
    conn = delete conn, stock_trade_path(conn, :delete, stock_trade)
    assert response(conn, 204)
    refute Repo.get(StockTrade, stock_trade.id)
  end
end
