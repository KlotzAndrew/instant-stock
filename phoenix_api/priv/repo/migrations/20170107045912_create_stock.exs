defmodule PhoenixApi.Repo.Migrations.CreateStock do
  use Ecto.Migration

  def change do
    create table(:stocks) do
      add :ticker, :string, null: false
      add :stock_exchange, :string, null: false
      add :name, :string
      add :currency, :string, null: false

      timestamps()
    end

  end
end
