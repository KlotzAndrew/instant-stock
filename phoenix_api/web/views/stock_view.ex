defmodule PhoenixApi.StockView do
  use PhoenixApi.Web, :view

  def render("index.json", %{stocks: stocks}) do
    %{data: render_many(stocks, PhoenixApi.StockView, "stock.json")}
  end

  def render("show.json", %{stock: stock}) do
    %{data: render_one(stock, PhoenixApi.StockView, "stock.json")}
  end

  def render("stock.json", %{stock: stock}) do
    %{id: stock.id,
      ticker: stock.ticker,
      stock_exchange: stock.stock_exchange,
      name: stock.name,
      currency: stock.currency}
  end
end
