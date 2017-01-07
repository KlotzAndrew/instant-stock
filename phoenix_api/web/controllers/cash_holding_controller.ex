defmodule PhoenixApi.CashHoldingController do
  use PhoenixApi.Web, :controller

  alias PhoenixApi.CashHolding

  def index(conn, _params) do
    cash_holdings = Repo.all(CashHolding)
    render(conn, "index.json", data: cash_holdings)
  end

  def create(conn, %{"cash_holding" => cash_holding_params}) do
    changeset = CashHolding.changeset(%CashHolding{}, cash_holding_params)

    case Repo.insert(changeset) do
      {:ok, cash_holding} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", cash_holding_path(conn, :show, cash_holding))
        |> render("show.json", cash_holding: cash_holding)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PhoenixApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    cash_holding = Repo.get!(CashHolding, id)
    render(conn, "show.json", cash_holding: cash_holding)
  end

  def update(conn, %{"id" => id, "cash_holding" => cash_holding_params}) do
    cash_holding = Repo.get!(CashHolding, id)
    changeset = CashHolding.changeset(cash_holding, cash_holding_params)

    case Repo.update(changeset) do
      {:ok, cash_holding} ->
        render(conn, "show.json", cash_holding: cash_holding)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PhoenixApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    cash_holding = Repo.get!(CashHolding, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(cash_holding)

    send_resp(conn, :no_content, "")
  end
end
