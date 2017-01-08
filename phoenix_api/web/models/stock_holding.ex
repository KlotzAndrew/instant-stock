defmodule PhoenixApi.StockHolding do
  use PhoenixApi.Web, :model

  schema "stock_holdings" do
    belongs_to :portfolio, PhoenixApi.Portfolio
    belongs_to :stock, PhoenixApi.Stock
    has_many :stock_trades, PhoenixApi.StockTrade

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:stock_id, :portfolio_id])
    |> validate_required([:stock_id, :portfolio_id])
  end
end
