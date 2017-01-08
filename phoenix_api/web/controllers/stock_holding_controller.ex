defmodule PhoenixApi.StockHoldingController do
  use PhoenixApi.Web, :controller

  alias PhoenixApi.StockHolding

  def index(conn, _params) do
    stock_holdings = Repo.all(StockHolding)
    full_holding = Repo.preload(stock_holdings, :stock_trades)
    render(conn, "index.json", data: full_holding)
  end

  def create(conn, %{"stock_holding" => stock_holding_params}) do
    changeset = StockHolding.changeset(%StockHolding{}, stock_holding_params)

    case Repo.insert(changeset) do
      {:ok, stock_holding} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", stock_holding_path(conn, :show, stock_holding))
        |> render("show.json", data: stock_holding)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PhoenixApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    stock_holding = Repo.get!(StockHolding, id)
    render(conn, "show.json", data: stock_holding)
  end

  def update(conn, %{"id" => id, "stock_holding" => stock_holding_params}) do
    stock_holding = Repo.get!(StockHolding, id)
    changeset = StockHolding.changeset(stock_holding, stock_holding_params)

    case Repo.update(changeset) do
      {:ok, stock_holding} ->
        render(conn, "show.json", data: stock_holding)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PhoenixApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    stock_holding = Repo.get!(StockHolding, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(stock_holding)

    send_resp(conn, :no_content, "")
  end
end
