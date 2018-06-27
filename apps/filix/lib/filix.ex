defmodule Filix do
  @moduledoc """
  Client facing API for Filix.

  Consumed by FilixWeb in varying capacities.

  Uses FilixPersistence for long term storage and querying.

  Currently uses ExAws.S3 for object storage, however the goal is to make the interface generic enough to use any static object storage service.
  Maybe even decentralized blockchain solutions.
  """

  # Use the pre_signed_url as the identifier of active processes
  alias Filix.Uploading.{UploadService, UploadServiceSupervisor}

  def request_upload(file_params) do
    {:ok, file_params} = UploadServiceSupervisor.request_upload(file_params)
  end

  def initiate_upload(upload_pid) do
    UploadServiceSupervisor.call(upload_pid)
  end

  def cancel_upload() do
  end

  def update_upload_progress(upload_pid, progress) do
    UploadServiceSupervisor.update_upload_progress(upload_pid, progress)
  end

  def reinitiate_upload() do
  end

  def get_upload_status(upload_pid) do

  end
end
