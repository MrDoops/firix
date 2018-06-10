defmodule FilixPersistence.Repo.Migrations.CreateFileTags do
  use Ecto.Migration

  def change do
    create table(:file_tags) do
      add :file_id, references(:files, on_delete: :nothing),
        null: false
      add :tag_id, references(:tags, on_delete: :nothing),
        null: false

      timestamps()
    end

    create index(:file_tags, [:file_id])
    create index(:file_tags, [:tag_id])
    create unique_index(:file_tags, [:file_id, :tag_id])
  end
end
