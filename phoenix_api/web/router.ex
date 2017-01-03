defmodule PhoenixApi.Router do
  use PhoenixApi.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json-api"]
  end

  scope "/", PhoenixApi do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api/v1", PhoenixApi do
    pipe_through :api

    resources "/portfolios", PortfolioController
    get "/promo", PortfolioController, :promo
  end
end
