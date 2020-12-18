use Mix.Config

config :graph_banking,
  ecto_repos: [GraphBanking.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :graph_banking, GraphBankingWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "a+k5UScKDk5oaizbUdyEKGHkHc1cUHQJsXGZScJQULv8UCGpUQc5LHspaF0lgHPn",
  render_errors: [view: GraphBankingWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: GraphBanking.PubSub,
  live_view: [signing_salt: "D8phpTyw"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
