defmodule PhoenixApi.CashHolding do
  use PhoenixApi.Web, :model

  schema "cash_holdings" do
    field :currency, :string
    belongs_to :portfolio, PhoenixApi.Portfolio
    has_many :cash_trades, PhoenixApi.CashTrade

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:currency, :portfolio_id])
    |> validate_required([:currency, :portfolio_id])
  end
end
