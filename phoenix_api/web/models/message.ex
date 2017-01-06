defmodule PhoenixApi.Message do
  use PhoenixApi.Web, :model

  schema "messages" do
    field :content, :string
    belongs_to :portfolio, PhoenixApi.Portfolio

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:content, :portfolio_id])
    |> validate_required([:content, :portfolio_id])
  end
end
