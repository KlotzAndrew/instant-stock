defmodule PhoenixApi.PortfolioView do
  use PhoenixApi.Web, :view

  def render("index.json", %{portfolios: portfolios}) do
    %{data: render_many(portfolios, PhoenixApi.PortfolioView, "portfolio.json")}
  end

  def render("show.json", %{portfolio: portfolio}) do
    %{data: render_one(portfolio, PhoenixApi.PortfolioView, "portfolio.json")}
  end

  def render("portfolio.json", %{portfolio: portfolio}) do
    %{id: portfolio.id,
      name: portfolio.name}
  end
end
