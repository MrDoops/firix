defmodule Filix.File do
  @moduledoc """
  Used largely to enforce required paramters and types when requesting an upload
  """
  use TypedStruct

  typedstruct do
    field :name, String.t(), enforce: true
    field :size, integer(), enforce: true
    field :type, String.t(), enforce: true
    field :url, String.t(), default: nil
    field :tags, nonempty_list(String.t()), enforce: true
  end
end
