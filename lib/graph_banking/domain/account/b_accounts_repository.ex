defmodule GraphBanking.Repository.BAccountsRepository do
  @moduledoc false
  alias GraphBanking.Model.Account
  alias GraphBanking.Persistence.Account, as: AccountSchema
  alias GraphBanking.Repository.Accounts

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
