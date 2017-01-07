defmodule PhoenixApi.Stock do
  use PhoenixApi.Web, :model

  schema "stocks" do
    field :ticker, :string
    field :stock_exchange, :string
    field :name, :string
    field :currency, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:ticker, :stock_exchange, :name, :currency])
    |> validate_required([:ticker, :stock_exchange, :name, :currency])
  end
end
