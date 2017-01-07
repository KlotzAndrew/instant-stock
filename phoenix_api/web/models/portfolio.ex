defmodule PhoenixApi.Portfolio do
  use PhoenixApi.Web, :model

  schema "portfolios" do
    field :name, :string
    has_many :messages, PhoenixApi.Message
    has_many :cash_holdings, PhoenixApi.CashHolding
    has_many :stock_holdings, PhoenixApi.StockHolding

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
