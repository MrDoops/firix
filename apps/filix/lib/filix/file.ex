defmodule Filix.File do
  @moduledoc """
  Typed File Struct used to enforce types and presence of fields.
  """
  use TypedStruct

  @typedoc """
  A file
  """
  typedstruct do
    field :name, String.t(), enforce: true
    field :id, String.t()
    field :size, integer(), enforce: true
    field :type, String.t(), enforce: true
    field :url, String.t(), default: nil
    field :status, atom(), default: :upload_requested
    field :upload_progress, non_neg_integer(), default: 0
    field :tags, nonempty_list(String.t()), enforce: true
  end

  @spec new(map()) :: Filix.File.t()
  def new(
    %{
      "name" => name,
      "size" => size,
      "type" => type,
      "tags" => tags,
    }
  ) do
    %__MODULE__{
      name: name,
      size: size,
      type: type,
      tags: tags,
    }
  end
end
