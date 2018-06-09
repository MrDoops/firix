use Mix.Config

config :logger, :console, format: "[$level] $message\n"

config :filix_db, FilixDb.Repo,
adapter: Ecto.Adapters.Postgres,
username: "postgres",
password: "postgres",
database: "filix_db_dev",
hostname: "localhost",
pool_size: 10
