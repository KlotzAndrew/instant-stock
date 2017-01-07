defmodule PhoenixApi.CashHoldingView do
  use PhoenixApi.Web, :view
  use JaSerializer.PhoenixView

  alias PhoenixApi.Repo

  attributes [:currency, :current_total]

  def current_total(cash_holding, _conn) do
    full_hold = Repo.preload(cash_holding, :cash_trades)

    Enum.reduce(
      full_hold.cash_trades,
      Decimal.new(0),
      fn(x, acc) -> Decimal.add(x.quantity, acc) end
    )
  end
end
