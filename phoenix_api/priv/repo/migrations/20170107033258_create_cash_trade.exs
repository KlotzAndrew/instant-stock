defmodule PhoenixApi.Repo.Migrations.CreateCashTrade do
  use Ecto.Migration

  def change do
    create table(:cash_trades) do
      add :cash_holding_id, :integer, null: false
      add :quantity, :decimal, precision: 15, scale: 2

      timestamps()
    end

  end
end
