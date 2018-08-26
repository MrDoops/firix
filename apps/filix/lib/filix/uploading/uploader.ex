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
  alias Filix.StorageServices.AwsS3
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
    GenServer.cast(file_id, :update_upload_progress, progress)
  end

  def reinitiate_upload(file_id) do
    GenServer.cast(file_id, :reinitiate_upload)
  end

  def status(file_id) do
    GenServer.call(file_id, :status)
  end

  # Server callbacks

  def handle_call(:request_upload, _from, file) do
    file
    |> assign_id()
    |> StorageProvider.setup_storage_resources()
    |> check_status(:request_upload)
  end

  def handle_cast(:update_upload_progress, %File{status: status} = file) do
    {:normal, data} = status(self())

    cond do
      (progress >= 100) ->
        {:next_state, :complete, Map.put(data, :progress, progress)}
      (progress > 0 && progress < 100) ->
        {:next_state, :uploading, Map.put(data, :progress, progress)}
    end
  end

  def handle_event(:cast, :reinitiate_upload, state, data) do
    #
  end

  def handle_event(:cast, :cancel_upload, state, data) do
    # destroy storage resources
  end

  def handle_event({:call, from}, :status, state, data) do
    {:next_state, state, data, [{:reply, from, {state, data} }]}
  end



  defp assign_id(%File{} = file), do: %File{ file | id: UUID.uuid4()}
end
