defmodule Filix.Uploading.UploadService do
  @moduledoc """
  Manages the complexity of uploading a file.

  States:
    :upload_requested
    :storage_resources_prepared
    :uploading
    :upload_completed
    :upload_on_hold
    :upload_cancelled

  Commands:
    :initiate_upload
    :update_upload_progress
    :reinitiate_upload
    :cancel_upload

  """
  use GenStateMachine

  alias Filix.Uploading.UploadService
  alias Filix.StorageServices.S3
  alias Firix.FilixPersistence
  alias Filix.Commands.{
    InitiateUpload,
    UpdateUploadProgress,
    ReinitiateUpload,
    CancelUpload,
  }

  @max_upload_progress 100

  # Client

  def start_link() do
    GenStateMachine.start_link(UploadService, {:upload_requested, %{upload_progress: 0}})
  end

  # Still not sure if use of Structs should be enforced. Maybe just hold the state in a struct...
  def initiate_upload(pid, %InitiateUpload{} = initiate_upload) do
    GenStateMachine.call(pid, :initiate_upload)
  end

  def cancel_upload(pid) do
    GenStateMachine.call(pid, :cancel_upload)
  end

  def update_upload_progress(pid) do
    GenStateMachine.cast(pid, :update_upload_progress)
  end

  def reinitiate_upload(pid) do
    GenStateMachine.cast(pid, :reinitiate_upload)
  end

  # Server callbacks

  def handle_event({:call, from}, :upload_requested, data) do
    # S3.setup_storage_resources()
    {:next_state}
  end

  def handle_event(event_type, event_content, state, data) do
    super(event_type, event_content, state, data)
  end
end
