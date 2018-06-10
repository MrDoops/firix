defmodule FilixPersistence.File do
  use Ecto.Schema
  import Ecto.Changeset
  alias FilixPersistence.{File, Tag, FileTag}
  alias FilixPersistence.Repo

  schema "files" do
    field :name, :string
    field :url, :string
    field :size, :integer
    file :type, :string

    many_to_many :tags, Tag, join_through: FileTag

    timestamps()
  end

  @doc false
  def changeset(%File{} = file, attrs) do
    file
    |> cast(attrs, [:name, :url, :type, :size])
    |> validate_required([:name, :url, :type, :size])
    |> put_assoc(:tags, get_or_insert_tag(attrs), required: true)
  end

  defp get_or_insert_tag(%{tags: names}) do
    names
    |> Enum.map(fn name ->
      {:ok, tag} = %Tag{name: name}
      |> Repo.insert(
        on_conflict: [set: [name: name]],
        conflict_target: :name
      )
      tag
    end)
  end

end
