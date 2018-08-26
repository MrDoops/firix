defmodule Filix.Uploading.UploadServiceSupervisor do
  @moduledoc """
  Dynamic Supervisor responsible for spawning upload services whenever needed.
  """

  use DynamicSupervisor

  alias Filix.Uploading.UploadService

  def start_link(arg) do
    DynamicSupervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @impl true
  def init(_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def request_upload(file_params) do
    child_spec = {UploadService, file_params}
    DynamicSupervisor.start_child(__MODULE__, child_spec)
  end

  def cancel_upload(file_id) do

  end

  def status(file_id), do:
    UploadService
end
