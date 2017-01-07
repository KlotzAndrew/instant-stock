defmodule PhoenixApi.PortfolioView do
  use PhoenixApi.Web, :view
  use JaSerializer.PhoenixView

  attributes [:name]

  has_many :messages,
    serializer: PhoenixApi.MessageView,
    include: true

  has_many :cash_holdings,
    serializer: PhoenixApi.CashHoldingView,
    include: true

end
