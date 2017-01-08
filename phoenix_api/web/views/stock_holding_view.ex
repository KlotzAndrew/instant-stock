defmodule PhoenixApi.StockHoldingView do
  import Ecto.Query, only: [from: 2]
  use PhoenixApi.Web, :view
  use JaSerializer.PhoenixView

  alias PhoenixApi.Repo
  alias PhoenixApi.MinuteBar

  attributes [:stock_name, :last_quote, :current_total]

  def stock_name(stock_holding, _conn) do
    full_holding = Repo.preload(stock_holding, :stock)

    full_holding.stock.name
  end

  def last_quote(stock_holding, _conn) do
    full_holding = Repo.preload(stock_holding, :stock)
    stock = full_holding.stock

    query = from(m in MinuteBar, order_by: m.inserted_at, where: m.stock_id == ^stock.id)
    minute_bars = Repo.all(query)
    last_bar = Enum.at(minute_bars, 0)
    last_bar.close
  end

  def current_total(stock_holding, _conn) do
    full_holding = Repo.preload(stock_holding, :stock_trades)
    trades = full_holding.stock_trades

    Enum.reduce(trades, 0, fn(trade, acc) -> trade.quantity + acc end)
  end
end
