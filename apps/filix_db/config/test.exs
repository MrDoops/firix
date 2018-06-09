use Mix.Config

config :logger, level: :warn

config :filix_db, FilixDb.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "filix_db_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
  pool: Ecto.Adapters.SQL.Sandbox
