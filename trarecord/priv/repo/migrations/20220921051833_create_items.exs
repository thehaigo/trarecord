defmodule Trarecord.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :name, :string
      add :url, :string
      add :image, :string
      add :category, :string
      add :status, :boolean, default: false, null: false

      timestamps()
    end
  end
end
