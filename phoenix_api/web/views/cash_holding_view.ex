defmodule PhoenixApi.CashHoldingView do
  use PhoenixApi.Web, :view
  use JaSerializer.PhoenixView

  attributes [:currency]

  # def render("index.json", %{cash_holdings: cash_holdings}) do
  #   %{data: render_many(cash_holdings, PhoenixApi.CashHoldingView, "cash_holding.json")}
  # end
  #
  # def render("show.json", %{cash_holding: cash_holding}) do
  #   %{data: render_one(cash_holding, PhoenixApi.CashHoldingView, "cash_holding.json")}
  # end
  #
  # def render("cash_holding.json", %{cash_holding: cash_holding}) do
  #   %{id: cash_holding.id,
  #     currency: cash_holding.currency,
  #     portfolio_id: cash_holding.portfolio_id}
  # end
end
