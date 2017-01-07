defmodule PhoenixApi.CashTradeController do
  use PhoenixApi.Web, :controller

  alias PhoenixApi.CashTrade

  def index(conn, _params) do
    cash_trades = Repo.all(CashTrade)
    render(conn, "index.json", cash_trades: cash_trades)
  end

  def create(conn, %{"cash_trade" => cash_trade_params}) do
    changeset = CashTrade.changeset(%CashTrade{}, cash_trade_params)

    case Repo.insert(changeset) do
      {:ok, cash_trade} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", cash_trade_path(conn, :show, cash_trade))
        |> render("show.json", cash_trade: cash_trade)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PhoenixApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    cash_trade = Repo.get!(CashTrade, id)
    render(conn, "show.json", cash_trade: cash_trade)
  end

  def update(conn, %{"id" => id, "cash_trade" => cash_trade_params}) do
    cash_trade = Repo.get!(CashTrade, id)
    changeset = CashTrade.changeset(cash_trade, cash_trade_params)

    case Repo.update(changeset) do
      {:ok, cash_trade} ->
        render(conn, "show.json", cash_trade: cash_trade)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PhoenixApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    cash_trade = Repo.get!(CashTrade, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(cash_trade)

    send_resp(conn, :no_content, "")
  end
end
