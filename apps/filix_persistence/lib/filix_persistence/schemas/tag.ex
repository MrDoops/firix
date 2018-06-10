defmodule FilixPersistence.Tag do
  use Ecto.Schema
  import Ecto.Changeset
  alias FilixPersistence.{File, FileTag}


  schema "tags" do
    field :name, :string

    many_to_many :files, File, join_through: FileTag

    timestamps()
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
