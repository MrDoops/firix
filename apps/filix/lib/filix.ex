defmodule Filix do
  @moduledoc """
  Client facing API for Filix.

  Consumed by FilixWeb in varying capacities.

  Uses FilixPersistence for long term storage and querying.

  Currently uses ExAws.S3 for object storage, however the goal is to make the interface generic enough to use any static object storage service.
  Maybe even decentralized blockchain solutions.
  """



  # Use the pre_signed_url as the identifier of active processes
  alias Filix.Uploading.UploadService

  def request_upload(file_params) do
    # UploadService.start_link()

    # {:ok, storage_resources_prepared}
  end

  def initiate_upload() do
  end

  def cancel_upload() do
  end

  def update_upload_progress() do
  end

  def reinitiate_upload() do
  end
end
