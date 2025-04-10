import Config

config :load_test, Repo,
  username: "dev",
  password: "dev",
  hostname: "localhost",
  database: "load_test_dev",
  pool_size: 10
