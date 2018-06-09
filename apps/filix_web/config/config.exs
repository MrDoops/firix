# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :filix_web,
  namespace: FilixWeb

# Configures the endpoint
config :filix_web, FilixWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "wOXzR6hvs/ADbeTpniwbXPyxHGX4MzSyNFFvwQD6L83fLJYiGcANEJJtayUGC2NJ",
  render_errors: [view: FilixWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: FilixWeb.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :filix_web, :generators,
  context_app: false

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
