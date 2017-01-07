defmodule PhoenixApi.MinuteBar do
  use PhoenixApi.Web, :model

  schema "minute_bars" do
    belongs_to :stock, PhoenixApi.Stock
    field :data_source, :string
    field :quote_time, Ecto.DateTime
    field :high, :decimal
    field :open, :decimal
    field :close, :decimal
    field :low, :decimal
    field :adjusted_close, :decimal
    field :volume, :decimal

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:stock_id, :data_source, :quote_time, :high, :open, :close, :low, :adjusted_close, :volume])
    |> validate_required([:stock_id, :data_source, :quote_time, :high, :open, :close, :low, :adjusted_close, :volume])
  end
end
