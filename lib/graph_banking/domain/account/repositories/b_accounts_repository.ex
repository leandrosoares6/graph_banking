defmodule GraphBanking.Domain.Account.Repositories.BAccountsRepository do
  @moduledoc false
  alias GraphBanking.Domain.Account.Entities.Account
  alias GraphBanking.Domain.Account.Infrastructure.Persistence.Account, as: AccountSchema
  alias GraphBanking.Domain.Account.Infrastructure.Persistence.AccountsRepository, as: Accounts

  @callback create(balance :: float) :: %Account{} | {:error, String.t()}
  @callback get(uuid :: String.t()) :: %AccountSchema{} | nil

  def create(args, adapter_type \\ :ecto) do
    repository_impl = repository_for(adapter_type)
    repository_impl.create(args)
  end

  def get(args, adapter_type \\ :ecto) do
    repository_impl = repository_for(adapter_type)
    repository_impl.get(args)
  end

  defp repository_for(:ecto), do: Accounts
end
