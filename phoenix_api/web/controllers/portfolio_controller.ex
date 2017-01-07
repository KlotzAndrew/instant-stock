defmodule PhoenixApi.PortfolioController do
  use PhoenixApi.Web, :controller

  alias PhoenixApi.Portfolio

  def promo(conn, _params) do
    portfolio = Enum.at(Repo.all(Portfolio), 0)
    full_portfolio = Repo.preload(portfolio, :cash_holdings)
    full_portfolio = Repo.preload(full_portfolio, :stock_holdings)
    full_portfolio = Repo.preload(full_portfolio, :messages)
    render(conn, "show.json", data: full_portfolio)
  end

  def index(conn, _params) do
    portfolios = Repo.all(Portfolio)
    render(conn, "index.json", data: portfolios)
  end

  def create(conn, %{"portfolio" => portfolio_params}) do
    changeset = Portfolio.changeset(%Portfolio{}, portfolio_params)

    case Repo.insert(changeset) do
      {:ok, portfolio} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", portfolio_path(conn, :show, portfolio))
        |> render("show.json", data: portfolio)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PhoenixApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    portfolio = Repo.get!(Portfolio, id)
    render(conn, "show.json", data: portfolio)
  end

  def update(conn, %{"id" => id, "portfolio" => portfolio_params}) do
    portfolio = Repo.get!(Portfolio, id)
    changeset = Portfolio.changeset(portfolio, portfolio_params)

    case Repo.update(changeset) do
      {:ok, portfolio} ->
        render(conn, "show.json", data: portfolio)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PhoenixApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    portfolio = Repo.get!(Portfolio, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(portfolio)

    send_resp(conn, :no_content, "")
  end
end
