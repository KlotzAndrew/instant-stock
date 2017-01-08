defmodule PhoenixApi.StockTrade do
  use PhoenixApi.Web, :model

  schema "stock_trades" do
    belongs_to :stock_holding, PhoenixApi.StockHolding
    field :quantity, :integer
    field :enter_price, :decimal
    field :exit_price, :decimal
    field :exit_time, Ecto.DateTime

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:stock_holding_id, :quantity, :enter_price, :exit_price, :exit_time])
    |> validate_required([:stock_holding_id, :quantity, :enter_price, :exit_price, :exit_time])
  end
end
