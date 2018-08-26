defmodule Filix do
  @moduledoc """
  Client facing API for Filix.

  Consumed by FilixWeb in varying capacities.

  Uses FilixPersistence for long term storage and querying.

  Currently uses ExAws.S3 for object storage, however the goal is to make the interface generic enough to use any static object storage service.
  Maybe even decentralized blockchain solutions.
  """

  # Use the pre_signed_url as the identifier of active processes
  alias Filix.Uploading.UploadServiceSupervisor

  def request_upload(file_params) do
    UploadServiceSupervisor.request_upload(file_params)
  end
end
