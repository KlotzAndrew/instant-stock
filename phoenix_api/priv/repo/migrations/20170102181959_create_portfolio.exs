defmodule PhoenixApi.Repo.Migrations.CreatePortfolio do
  use Ecto.Migration

  def change do
    create table(:portfolios) do
      add :name, :string

      timestamps()
    end

  end
end
