defmodule FilixDb.Application do
  @moduledoc false
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      FilixDb.Repo,
    ]

    opts = [strategy: :one_for_one, name: FilixDb.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
