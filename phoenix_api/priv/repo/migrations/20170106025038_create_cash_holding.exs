defmodule PhoenixApi.Repo.Migrations.CreateCashHolding do
  use Ecto.Migration

  def change do
    create table(:cash_holdings) do
      add :currency, :string, null: false
      add :portfolio_id, :integer, null: false

      timestamps()
    end

  end
end
