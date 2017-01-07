defmodule PhoenixApi.StockTradeView do
  use PhoenixApi.Web, :view

  def render("index.json", %{stock_trades: stock_trades}) do
    %{data: render_many(stock_trades, PhoenixApi.StockTradeView, "stock_trade.json")}
  end

  def render("show.json", %{stock_trade: stock_trade}) do
    %{data: render_one(stock_trade, PhoenixApi.StockTradeView, "stock_trade.json")}
  end

  def render("stock_trade.json", %{stock_trade: stock_trade}) do
    %{id: stock_trade.id,
      stock_holding_id: stock_trade.stock_holding_id,
      quantity: stock_trade.quantity,
      enter_price: stock_trade.enter_price,
      exit_price: stock_trade.exit_price,
      exit_time: stock_trade.exit_time}
  end
end
