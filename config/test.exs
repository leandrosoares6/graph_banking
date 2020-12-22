use Mix.Config

config :graph_banking,
  accounts_repository_impl:
    GraphBanking.Domain.Account.Repositories.Fakes.FakeAccountsRepository

config :graph_banking,
  transfers_repository_impl:
    GraphBanking.Domain.Account.Repositories.Fakes.FakeTransfersRepository
