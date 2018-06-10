defmodule Filix.Uploading.UploadService do
  use GenStateMachine

  alias Filix.Uploading.UploadService
  alias Filix.StorageServices.S3
  alias Firix.FilixPersistence

  @max_upload_progress 100

  # Client

  def start_link() do
    GenStateMachine.start_link(UploadService, {:upload_requested, %{upload_progress: 0}})
  end

  def initiate_upload(pid) do
  end

  def cancel_upload(pid) do
  end

  def update_upload_progress(pid) do
  end

  def reinitiate_upload(pid) do
  end

  # Server

  def handle_event({:call, from}, :upload_requested, data) do
    {:}
  end
end
