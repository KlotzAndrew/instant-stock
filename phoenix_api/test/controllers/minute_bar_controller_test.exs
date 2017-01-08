defmodule PhoenixApi.MinuteBarControllerTest do
  use PhoenixApi.ConnCase

  alias PhoenixApi.MinuteBar
  @valid_attrs %{adjusted_close: "120.5", close: "120.5", data_source: "some content", high: "120.5", low: "120.5", open: "120.5", quote_time: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, stock_id: 42, volume: "120.5"}
  @invalid_attrs %{stock_id: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, minute_bar_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    minute_bar = Repo.insert! %MinuteBar{
      adjusted_close: 120.5,
      close: 120.5,
      data_source: "some content",
      high: 120.5,
      low: 120.5,
      open: 120.5,
      quote_time: Ecto.DateTime.utc,
      stock_id: 42,
      volume: 120.5
    }
    conn = get conn, minute_bar_path(conn, :show, minute_bar)
    assert json_response(conn, 200)["data"] == %{
      "id" => Integer.to_string(minute_bar.id),
      "attributes" => %{},
      "type" => "minute-bar"
    }
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, minute_bar_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, minute_bar_path(conn, :create), minute_bar: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(MinuteBar, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, minute_bar_path(conn, :create), minute_bar: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    minute_bar = Repo.insert! %MinuteBar{
      adjusted_close: 120.5,
      close: 120.5,
      data_source: "some content",
      high: 120.5,
      low: 120.5,
      open: 120.5,
      quote_time: Ecto.DateTime.utc,
      stock_id: 42,
      volume: 120.5
    }
    conn = put conn, minute_bar_path(conn, :update, minute_bar), minute_bar: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(MinuteBar, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    minute_bar = Repo.insert! %MinuteBar{
      adjusted_close: 120.5,
      close: 120.5,
      data_source: "some content",
      high: 120.5,
      low: 120.5,
      open: 120.5,
      quote_time: Ecto.DateTime.utc,
      stock_id: 42,
      volume: 120.5
    }
    conn = put conn, minute_bar_path(conn, :update, minute_bar), minute_bar: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    minute_bar = Repo.insert! %MinuteBar{
      adjusted_close: 120.5,
      close: 120.5,
      data_source: "some content",
      high: 120.5,
      low: 120.5,
      open: 120.5,
      quote_time: Ecto.DateTime.utc,
      stock_id: 42,
      volume: 120.5
    }
    conn = delete conn, minute_bar_path(conn, :delete, minute_bar)
    assert response(conn, 204)
    refute Repo.get(MinuteBar, minute_bar.id)
  end
end
