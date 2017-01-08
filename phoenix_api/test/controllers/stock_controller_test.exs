defmodule PhoenixApi.StockControllerTest do
  use PhoenixApi.ConnCase

  alias PhoenixApi.Stock
  @valid_attrs %{currency: "some content", name: "some content", stock_exchange: "some content", ticker: "some content"}
  @invalid_attrs %{ticker: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, stock_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    stock = Repo.insert! %Stock{currency: "some content", name: "some content", stock_exchange: "some content", ticker: "some content"}
    conn = get conn, stock_path(conn, :show, stock)
    assert json_response(conn, 200)["data"] == %{"id" => stock.id,
      "ticker" => stock.ticker,
      "stock_exchange" => stock.stock_exchange,
      "name" => stock.name,
      "currency" => stock.currency}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, stock_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, stock_path(conn, :create), stock: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Stock, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, stock_path(conn, :create), stock: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    stock = Repo.insert! %Stock{currency: "some content", name: "some content", stock_exchange: "some content", ticker: "some content"}
    conn = put conn, stock_path(conn, :update, stock), stock: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Stock, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    stock = Repo.insert! %Stock{currency: "some content", name: "some content", stock_exchange: "some content", ticker: "some content"}
    conn = put conn, stock_path(conn, :update, stock), stock: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    stock = Repo.insert! %Stock{currency: "some content", name: "some content", stock_exchange: "some content", ticker: "some content"}
    conn = delete conn, stock_path(conn, :delete, stock)
    assert response(conn, 204)
    refute Repo.get(Stock, stock.id)
  end
end
