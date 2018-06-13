defmodule Filix.Uploading.UploadServiceSupervisor do
  @moduledoc """
  Dynamic Supervisor responsible for spawning upload services whenever needed.
  """

  use DynamicSupervisor

  def start_link(arg) do
    DynamicSupervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @impl true
  def init(_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end
