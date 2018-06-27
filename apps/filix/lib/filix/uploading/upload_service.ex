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
    :update_upload_progress
    :reinitiate_upload
    :cancel_upload

  """
  use GenStateMachine

  alias Filix.Uploading.UploadService
  alias Filix.File
  alias Filix.StorageServices.AwsS3
  alias Firix.FilixPersistence

  @max_upload_progress 100

  # Client

  def start_link(file_params = %File{}) do
    GenStateMachine.start_link(
      UploadService,
      {:upload_requested, %{file_params: file_params, upload_progress: 0}}
    )
  end

  # Still not sure if use of Structs should be enforced. Maybe just hold the state in a struct...
  def cancel_upload(pid) do
    GenStateMachine.call(pid, :cancel_upload)
  end

  def update_upload_progress(pid, progress) do
    GenStateMachine.cast(pid, :update_upload_progress, progress)
  end

  def reinitiate_upload(pid) do
    GenStateMachine.cast(pid, :reinitiate_upload)
  end

  def upload_status(pid) do
    GenStateMachine.call(pid, :status)
  end

  # Server callbacks

  def handle_event({:call, from}, :upload_requested, %{file_params: file_params}) do
    file_params
    |> Map.from_struct()
    |> Map.put(:file_id, UUID.uuid4())
    |> AwsS3.setup_storage_resources()

    {:next_state, :storage_resources_prepared, [{:reply, from, %{file_params: file_params}}]}
  end

  def handle_event(:cast, :update_upload_progress, :storage_resources_prepared, progress) when is_integer(progress) do
    case progress do
      100 ->
        {:next_state, :upload_completed, }
      _   ->
        {:next_state, :uploading, }
    end

    # {:next_state, :uploading, } # How to handle receiving an integer from the command?
  end

  def handle_event({:call, from}, :status, state, data) do
    {:next_state, state, data, [{:reply, from, data}]}
  end

  def handle_event(event_type, event_content, state, data) do
    super(event_type, event_content, state, data)
  end
end
