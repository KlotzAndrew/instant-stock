defmodule PhoenixApi.StockHolding do
  use PhoenixApi.Web, :model

  schema "stock_holdings" do
    field :stock_id, :integer
    belongs_to :portfolio, PhoenixApi.Portfolio

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
