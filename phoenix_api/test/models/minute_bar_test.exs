defmodule PhoenixApi.MinuteBarTest do
  use PhoenixApi.ModelCase

  alias PhoenixApi.MinuteBar

  @valid_attrs %{adjusted_close: "120.5", close: "120.5", data_source: "some content", high: "120.5", low: "120.5", open: "120.5", quote_time: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, stock_id: 42, volume: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = MinuteBar.changeset(%MinuteBar{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = MinuteBar.changeset(%MinuteBar{}, @invalid_attrs)
    refute changeset.valid?
  end
end
