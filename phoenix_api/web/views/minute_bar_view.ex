defmodule PhoenixApi.MinuteBarView do
  use PhoenixApi.Web, :view

  def render("index.json", %{minute_bars: minute_bars}) do
    %{data: render_many(minute_bars, PhoenixApi.MinuteBarView, "minute_bar.json")}
  end

  def render("show.json", %{minute_bar: minute_bar}) do
    %{data: render_one(minute_bar, PhoenixApi.MinuteBarView, "minute_bar.json")}
  end

  def render("minute_bar.json", %{minute_bar: minute_bar}) do
    %{id: minute_bar.id,
      stock_id: minute_bar.stock_id,
      data_source: minute_bar.data_source,
      quote_time: minute_bar.quote_time,
      high: minute_bar.high,
      open: minute_bar.open,
      close: minute_bar.close,
      low: minute_bar.low,
      adjusted_close: minute_bar.adjusted_close,
      volume: minute_bar.volume}
  end
end
