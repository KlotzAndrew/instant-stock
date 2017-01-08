defmodule PhoenixApi.StockTradeController do
  use PhoenixApi.Web, :controller

  alias PhoenixApi.StockTrade

  def index(conn, _params) do
    stock_trades = Repo.all(StockTrade)
    render(conn, "index.json", data: stock_trades)
  end

  def create(conn, %{"stock_trade" => stock_trade_params}) do
    changeset = StockTrade.changeset(%StockTrade{}, stock_trade_params)

    case Repo.insert(changeset) do
      {:ok, stock_trade} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", stock_trade_path(conn, :show, stock_trade))
        |> render("show.json", data: stock_trade)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PhoenixApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    stock_trade = Repo.get!(StockTrade, id)
    render(conn, "show.json", data: stock_trade)
  end

  def update(conn, %{"id" => id, "stock_trade" => stock_trade_params}) do
    stock_trade = Repo.get!(StockTrade, id)
    changeset = StockTrade.changeset(stock_trade, stock_trade_params)

    case Repo.update(changeset) do
      {:ok, stock_trade} ->
        render(conn, "show.json", data: stock_trade)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PhoenixApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    stock_trade = Repo.get!(StockTrade, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(stock_trade)

    send_resp(conn, :no_content, "")
  end
end
