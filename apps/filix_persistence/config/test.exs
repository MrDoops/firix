use Mix.Config

config :filix_persistence, FilixPersistence.Repo, [
  adapter: Ecto.Adapters.Postgres,
  database: "filix_persistence_#{Mix.env}",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox]

config :logger,
  backends: [:console],
  level: :warn,
  compile_time_purge_level: :info
