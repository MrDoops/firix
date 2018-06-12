defmodule Filix.Commands.InitiateUpload do
  defstruct [
    :file_name,
    :file_type,
    :file_size,
    :tags,
  ]
end
