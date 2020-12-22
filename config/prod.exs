use Mix.Config

config :graph_banking, GraphBankingWeb.Endpoint,
  url: [host: "example.com", port: 80],
  cache_static_manifest: "priv/static/cache_manifest.json"

config :logger, level: :info
import_config "prod.secret.exs"

config :graph_banking,
  accounts_repository_impl:
    GraphBanking.Domain.Account.Infrastructure.Persistence.AccountsRepository

config :graph_banking,
  transfers_repository_impl:
    GraphBanking.Domain.Account.Infrastructure.Persistence.TransfersRepository
