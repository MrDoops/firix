defmodule Filix.StorageServices.AwsS3 do
  @moduledoc """
    Holds any methods that have to do with Aws S3

    S3 things to do:
      - create buckets
      - fetch pre-signed urls
      - delete objects

    The goal is to turn this into an implemented behavior for one or many adapters.
  """
  alias ExAws.S3
  alias ExAws

  @root_bucket "filix"
  @host_name System.get_env("AWS_S3_HOST")

  def setup_storage_resources(%{} = file_params) do
    file_params
    |> Map.put(:presigned_url, fetch_presigned_url(file_params))
    |> Map.put(:url, get_file_url(file_params))
  end

  def fetch_presigned_url(%{file_type: file_type, file_id: file_id}) do
    query_params    = [{"ContentType", file_type}, {"ACL", "private"}]
    presign_options = [virtual_host: false, query_params: query_params]

    {:ok, presigned_url} =
      ExAws.Config.new(:s3)
      |> S3.presigned_url(:put, @root_bucket, "#{file_id}.#{file_type}", presign_options)

    presigned_url
  end

  # def destroy_storage_resources(%{file_id: file_id, url: url}) do

  # end

  defp get_file_url(file_params) do
    "https://s3.amazonaws.com/#{@host_name}/#{@root_bucket}/#{file_params.file_id}.#{file_params.file_type}"
  end

  defp root_bucket_existence() do
    {:ok, response} = S3.list_buckets() |> ExAws.request()

    bucket_existence =
      response
      |> Map.get(:body)
      |> Map.get(:buckets)
      |> Enum.any?(@root_bucket)
  end

end
