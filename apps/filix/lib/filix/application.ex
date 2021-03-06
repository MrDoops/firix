defmodule Filix.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  alias Filix.Uploading.UploadServiceSupervisor

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      {UploadServiceSupervisor, strategy: :one_for_one, name: UploadServiceSupervisor}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Filix.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
