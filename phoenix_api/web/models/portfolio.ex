defmodule PhoenixApi.Portfolio do
  use PhoenixApi.Web, :model

  schema "portfolios" do
    field :name, :string
    has_many :messages, PhoenixApi.Message

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
