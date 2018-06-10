defmodule Filix.StorageServices.S3 do
  @moduledoc """
    Holds any methods that have to do with Aws S3
  """

  alias ExAws.S3

  @root_bucket "filix"

  defp fetch_presigned_url(args) do

  end

  defp get_file_url(bucket, uuid, file) do
    "https://s3.amazonaws.com/#{root_bucket}/#{bucket}/#{uuid}.#{file.type}"
  end
end
