defmodule GraphBanking.Domain.Account.UseCases.GetAccount do
  @moduledoc false

  alias GraphBanking.Domain.Account.Repositories.BAccountsRepository, as: Accounts

  def apply(args) do
    case Accounts.get(args[:uuid]) do
      nil -> {:error, "Not found"}
      account -> {:ok, account}
    end
  end
end
