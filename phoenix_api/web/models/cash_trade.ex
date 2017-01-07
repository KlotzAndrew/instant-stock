defmodule PhoenixApi.CashTrade do
  use PhoenixApi.Web, :model

  schema "cash_trades" do
    belongs_to :cash_holding, PhoenixApi.CashHolding
    field :quantity, :decimal

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:cash_holding_id, :quantity])
    |> validate_required([:cash_holding_id, :quantity])
  end
end
