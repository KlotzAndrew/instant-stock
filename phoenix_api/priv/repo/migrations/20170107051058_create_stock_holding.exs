defmodule PhoenixApi.Repo.Migrations.CreateStockHolding do
  use Ecto.Migration

  def change do
    create table(:stock_holdings) do
      add :stock_id, :integer, null: false
      add :portfolio_id, :integer, null: false

      timestamps()
    end

  end
end
