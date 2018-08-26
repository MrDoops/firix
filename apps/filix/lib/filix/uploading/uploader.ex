defmodule Filix.Uploading.Uploader do
  @moduledoc """
  Manages the complexity of uploading a file.
  Stateful progression allows for monitored upload progress.
  Progression of states

  States:
    :requested
    :storage_resources_prepared
    :uploading
    :complete
    :upload_on_hold
    :upload_cancelled

  Commands:
    :update_upload_progress
    :reinitiate_upload
    :cancel_upload
    :upload_status

  This statemachine should be passed an adapter to use whatever library's functions.
  """
  use GenServer

  alias Filix.File
  alias Filix.Storage.AwsS3
  alias Firix.FilixPersistence
  import Filix.Uploading.UploadRules

  # Client

  def start_link(%File{} = file) do
    GenServer.start_link(
      __MODULE__,
      {:request_upload, file}
    )
  end

  def cancel_upload(file_id) do
    GenServer.call(file_id, :cancel_upload)
  end

  def update_progress(file_id, progress) when is_integer(progress) do
    GenServer.cast(file_id, {:update_upload_progress, progress})
  end

  def status(file_id) do
    GenServer.call(file_id, :status)
  end

  # Server callbacks

  def handle_call(:request_upload, _from, %File{} = file) do
    file
    |> assign_id()
    |> AwsS3.setup_storage_resources()
    |> check_status(:request_upload)

    {:ok, file}
  end

  def handle_cast({:update_upload_progress, progress}, %File{} = file) do
    %File{ file | upload_progress: progress}
    |> check_status(:update_upload_progress)
  end

  def handle_cast(:cancel_upload, _from, file) do
    # destroy storage resources
    # log cancellation
    # exit process
  end

  defp assign_id(%File{} = file), do: %File{ file | id: UUID.uuid4()}
end
