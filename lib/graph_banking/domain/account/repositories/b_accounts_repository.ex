defmodule GraphBanking.Domain.Account.Repositories.BAccountsRepository do
  @moduledoc false
  alias GraphBanking.Domain.Account.Entities.Account
  alias GraphBanking.Domain.Account.Infrastructure.Persistence.Account, as: AccountSchema

  @callback create(balance :: float) :: %Account{} | {:error, String.t()}
  @callback get(uuid :: String.t()) :: %AccountSchema{} | nil

  @accounts_repository_impl Application.get_env(
    :graph_banking, :accounts_repository_impl, RepositoryDefaultImplementation
  )

  def create(args) do
    @accounts_repository_impl.create(args)
  end

  def get(args) do
    @accounts_repository_impl.get(args)
  end
end
