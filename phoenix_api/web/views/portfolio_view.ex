defmodule PhoenixApi.PortfolioView do
  use PhoenixApi.Web, :view
  use JaSerializer.PhoenixView

  attributes [:name]

  has_many :messages,
    include: false

end
