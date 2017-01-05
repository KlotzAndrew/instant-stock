defmodule PhoenixApi.Repo.Migrations.CreateMessage do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :content, :string
      add :portfolio_id, :integer, null: false

      timestamps()
    end

  end
end
