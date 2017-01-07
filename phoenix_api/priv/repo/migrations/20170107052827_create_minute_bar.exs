defmodule PhoenixApi.Repo.Migrations.CreateMinuteBar do
  use Ecto.Migration

  def change do
    create table(:minute_bars) do
      add :stock_id, :integer, null: false
      add :data_source, :string, null: false
      add :quote_time, :utc_datetime, null: false

      add :high, :decimal, precision: 15, scale: 2
      add :open, :decimal, precision: 15, scale: 2
      add :close, :decimal, precision: 15, scale: 2
      add :low, :decimal, precision: 15, scale: 2
      add :adjusted_close, :decimal, precision: 15, scale: 2
      add :volume, :decimal, precision: 15, scale: 2

      timestamps()
    end

  end
end
