defmodule FilixPersistence.Repo.Migrations.CreateFiles do
  use Ecto.Migration

  def change do
    create table(:files) do
      add :name, :string
      add :url, :string
      add :file_type, :string
      add :file_size, :integer

      timestamps()
    end
  end
end
