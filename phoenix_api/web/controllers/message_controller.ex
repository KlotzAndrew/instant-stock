defmodule PhoenixApi.MessageController do
  use PhoenixApi.Web, :controller

  alias PhoenixApi.Message
  alias Commands.ExecuteTrade

  require Logger

  def index(conn, _params) do
    messages = Repo.all(Message)
    render(conn, "index.json", data: messages)
  end

  def create(conn, %{"message" => message_params}) do
    changeset = Message.changeset(%Message{}, message_params)

    case Repo.insert(changeset) do
      {:ok, message} ->
        PhoenixApi.Endpoint.broadcast! "room:lobby", "new:msg", %{"message" => %{"id" => message.id, "content" => message.content}}
        case ExecuteTrade.trade(message_params["content"], message_params["portfolio_id"]) do
          {:ok, trades} ->
            stock_trade = trades.stock_trade
            PhoenixApi.Endpoint.broadcast! "room:lobby", "new:msg", %{
              "stock_trade" => %{
                "data" => %{
                  "id" => stock_trade.id,
                  "attributes" => %{
                    "stockHoldingId" => stock_trade.stock_holding_id,
                    "quantity" => stock_trade.quantity,
                    "enterPrice" => stock_trade.enter_price
                  }
                }
            }}

            cash_trade = trades.cash_trade
            PhoenixApi.Endpoint.broadcast! "room:lobby", "new:msg", %{
              "cash_trade" => %{
                "data" => %{
                  "id" => cash_trade.id,
                  "attributes" => %{
                    "cashHoldingId" => cash_trade.cash_holding_id,
                    "quantity" => cash_trade.quantity
                  }
                }
            }}
          :nil ->
            # do nothing
        end

        conn
        |> put_status(:created)
        |> put_resp_header("location", message_path(conn, :show, message))
        |> render("show.json", data: message)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PhoenixApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    message = Repo.get!(Message, id)
    render(conn, "show.json", data: message)
  end

  def update(conn, %{"id" => id, "message" => message_params}) do
    message = Repo.get!(Message, id)
    changeset = Message.changeset(message, message_params)

    case Repo.update(changeset) do
      {:ok, message} ->
        render(conn, "show.json", data: message)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PhoenixApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    message = Repo.get!(Message, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(message)

    send_resp(conn, :no_content, "")
  end
end
