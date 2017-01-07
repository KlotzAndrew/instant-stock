defmodule PhoenixApi.Repo.Migrations.CreateStockTrade do
  use Ecto.Migration

  def change do
    create table(:stock_trades) do
      add :stock_holding_id, :integer, null: false
      add :quantity, :integer, null: false
      add :enter_price, :decimal, precision: 15, scale: 2
      add :exit_price, :decimal, precision: 15, scale: 2
      add :exit_time, :utc_datetime

      timestamps()
    end

  end
end
