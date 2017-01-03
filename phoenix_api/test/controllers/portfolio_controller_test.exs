defmodule PhoenixApi.PortfolioControllerTest do
  use PhoenixApi.ConnCase

  alias PhoenixApi.Portfolio
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/vnd.api+json")}
  end

  test "shows promo portfolio", %{conn: conn} do
    name = "Test port"
    portfolio = Repo.insert! %Portfolio{name: name}

    conn = get conn, portfolio_path(conn, :promo)
    assert json_response(conn, 200)["data"]["attributes"]["name"] == name
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, portfolio_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    portfolio = Repo.insert! %Portfolio{}
    conn = get conn, portfolio_path(conn, :show, portfolio)
    assert json_response(conn, 200)["data"]["id"] == Integer.to_string(portfolio.id)
    assert json_response(conn, 200)["data"]["attributes"]["name"] == portfolio.name
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, portfolio_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, portfolio_path(conn, :create), portfolio: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Portfolio, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, portfolio_path(conn, :create), portfolio: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    portfolio = Repo.insert! %Portfolio{}
    conn = put conn, portfolio_path(conn, :update, portfolio), portfolio: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Portfolio, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    portfolio = Repo.insert! %Portfolio{}
    conn = put conn, portfolio_path(conn, :update, portfolio), portfolio: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    portfolio = Repo.insert! %Portfolio{}
    conn = delete conn, portfolio_path(conn, :delete, portfolio)
    assert response(conn, 204)
    refute Repo.get(Portfolio, portfolio.id)
  end
end
