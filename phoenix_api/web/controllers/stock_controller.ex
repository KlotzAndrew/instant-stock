defmodule PhoenixApi.StockController do
  use PhoenixApi.Web, :controller

  alias PhoenixApi.Stock

  def index(conn, _params) do
    stocks = Repo.all(Stock)
    render(conn, "index.json", stocks: stocks)
  end

  def create(conn, %{"stock" => stock_params}) do
    changeset = Stock.changeset(%Stock{}, stock_params)

    case Repo.insert(changeset) do
      {:ok, stock} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", stock_path(conn, :show, stock))
        |> render("show.json", stock: stock)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PhoenixApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    stock = Repo.get!(Stock, id)
    render(conn, "show.json", stock: stock)
  end

  def update(conn, %{"id" => id, "stock" => stock_params}) do
    stock = Repo.get!(Stock, id)
    changeset = Stock.changeset(stock, stock_params)

    case Repo.update(changeset) do
      {:ok, stock} ->
        render(conn, "show.json", stock: stock)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PhoenixApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    stock = Repo.get!(Stock, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(stock)

    send_resp(conn, :no_content, "")
  end
end
