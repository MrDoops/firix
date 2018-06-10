defmodule FilixPersistence.FileTag do
  use Ecto.Schema
  import Ecto.Changeset
  alias FilixPersistence.FileTag

  @primary_key false
  schema "file_tags" do
    field :file_id, :id
    field :tag_id, :id

    timestamps()
  end

  @doc false
  def changeset(%FileTag{} = file_tag, attrs) do
    file_tag
    |> cast(attrs, [])
    |> validate_required([])
  end
end
