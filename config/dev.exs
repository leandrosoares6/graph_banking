use Mix.Config

# Configure your database
config :graph_banking, GraphBanking.Repo,
  username: "postgres",
  password: "docker",
  database: "graph_banking_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with webpack to recompile .js and .css sources.
config :graph_banking, GraphBankingWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []

config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime

config :graph_banking,
  accounts_repository_impl:
    GraphBanking.Domain.Account.Infrastructure.Persistence.AccountsRepository

config :graph_banking,
  transfers_repository_impl:
    GraphBanking.Domain.Account.Infrastructure.Persistence.TransfersRepository
