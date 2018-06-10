defmodule FilixPersistence do
  @moduledoc """
  Responsible for all Database (e.g. Ecto/Postgres) interaction for Filix.

  This module contains functions for CRUD actions against the database.

  It shouldn't be used directly unless for dataloading legacy files or seeding.

  A separate application should be used for User concerns.
  """
  import Ecto.Query, warn: false

  alias FilixPersistence.Repo
  alias FilixPersistence.{File, FileTag, Tag}

  def get_tag_by_name(tag_name) do
    Repo.get_by(Tag, name: tag_name)
  end

  def file_of_tag_name(tag_name) do
    Repo.all(
      from(
        file in File,
        preload: [:tags],
        join: tag in assoc(file, :tags),
        group_by: file.id,
        where: ^tag_name == tag.name
      )
    )
  end

  def list_files do
    File
    |> Repo.all()
    |> Repo.preload(:tags)
  end

  def list_files(args) do
    args
    |> Enum.reduce(File, fn
      {:order, order}, query ->
        query |> order_by({^order, :name})
      {:filter, filter}, query ->
        query |> filter_with(filter)
    end)
    |> Repo.all
  end

  def filter_with(query, filter) do
    Enum.reduce(filter, query, fn
      {:tag_name, tag_name}, query ->
        (
          from file in query,
          preload: [:tags],
          join: tag in assoc(file, :tags),
          group_by: file.id,
          where: ^tag_name == tag.name
        )
    end)
  end

  @doc """
  Gets a single file.

  Raises `Ecto.NoResultsError` if the File does not exist.

  ## Examples

      iex> get_file!(123)
      %File{}

      iex> get_file!(456)
      ** (Ecto.NoResultsError)

  """
  def get_file!(id) do
    File
    |> Repo.get!(id)
    |> Repo.preload(:tags)
  end

  @doc """
  Creates a file.

  ## Examples

      iex> create_file(%{field: value})
      {:ok, %File{}}

      iex> create_file(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_file(attrs) do
    %File{}
    |> File.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a file.

  ## Examples

      iex> update_file(file, %{field: new_value})
      {:ok, %File{}}

      iex> update_file(file, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_file(%File{} = file, attrs) do
    file
    |> File.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a File.

  ## Examples

      iex> delete_file(file)
      {:ok, %File{}}

      iex> delete_file(file)
      {:error, %Ecto.Changeset{}}

  """
  def delete_file(%File{} = file) do
    Repo.delete(file)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking file changes.

  ## Examples

      iex> change_file(file)
      %Ecto.Changeset{source: %File{}}

  """
  def change_file(%File{} = file) do
    File.changeset(file, %{})
  end



  @doc """
  Returns the list of tags.

  ## Examples

      iex> list_tags()
      [%Tag{}, ...]

  """
  def list_tags do
    Repo.all(Tag)
    |> Repo.preload(:files)
  end

  @doc """
  Gets a single tag.

  Raises `Ecto.NoResultsError` if the Tag does not exist.

  ## Examples

      iex> get_tag!(123)
      %Tag{}

      iex> get_tag!(456)
      ** (Ecto.NoResultsError)

  """
  def get_tag!(id) do
    Tag
    |> Repo.get!(id)
    |> Repo.preload(:files)
  end

  @doc """
  Creates a tag.

  ## Examples

      iex> create_tag(%{field: value})
      {:ok, %Tag{}}

      iex> create_tag(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tag(attrs \\ %{}) do
    %Tag{}
    |> Tag.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a tag.

  ## Examples

      iex> update_tag(tag, %{field: new_value})
      {:ok, %Tag{}}

      iex> update_tag(tag, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tag(%Tag{} = tag, attrs) do
    tag
    |> Tag.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Tag.

  ## Examples

      iex> delete_tag(tag)
      {:ok, %Tag{}}

      iex> delete_tag(tag)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tag(%Tag{} = tag) do
    Repo.delete(tag)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tag changes.

  ## Examples

      iex> change_tag(tag)
      %Ecto.Changeset{source: %Tag{}}

  """
  def change_tag(%Tag{} = tag) do
    Tag.changeset(tag, %{})
  end

  @doc """
  Returns the list of file_tags.

  ## Examples

      iex> list_file_tags()
      [%FileTag{}, ...]

  """
  def list_file_tags do
    Repo.all(FileTag)
  end

  @doc """
  Gets a single file_tag.

  Raises `Ecto.NoResultsError` if the File tag does not exist.

  ## Examples

      iex> get_file_tag!(123)
      %FileTag{}

      iex> get_file_tag!(456)
      ** (Ecto.NoResultsError)

  """
  def get_file_tag!(id), do: Repo.get!(FileTag, id)

  @doc """
  Creates a file_tag.

  ## Examples

      iex> create_file_tag(%{field: value})
      {:ok, %FileTag{}}

      iex> create_file_tag(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_file_tag(attrs \\ %{}) do
    %FileTag{}
    |> FileTag.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a file_tag.

  ## Examples

      iex> update_file_tag(file_tag, %{field: new_value})
      {:ok, %FileTag{}}

      iex> update_file_tag(file_tag, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_file_tag(%FileTag{} = file_tag, attrs) do
    file_tag
    |> FileTag.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a FileTag.

  ## Examples

      iex> delete_file_tag(file_tag)
      {:ok, %FileTag{}}

      iex> delete_file_tag(file_tag)
      {:error, %Ecto.Changeset{}}

  """
  def delete_file_tag(%FileTag{} = file_tag) do
    Repo.delete(file_tag)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking file_tag changes.

  ## Examples

      iex> change_file_tag(file_tag)
      %Ecto.Changeset{source: %FileTag{}}

  """
  def change_file_tag(%FileTag{} = file_tag) do
    FileTag.changeset(file_tag, %{})
  end
end
