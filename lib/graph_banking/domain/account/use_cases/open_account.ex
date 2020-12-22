defmodule GraphBanking.Domain.Account.UseCases.OpenAccount do
  @moduledoc false

  alias GraphBanking.Domain.Account.Infrastructure.Persistence.AccountsRepository, as: Accounts

  def apply(args) do
    case args |> Accounts.create() do
      {:error, error} ->
        {:error, error}

      account ->
        {:ok, account}
    end
  end
end
