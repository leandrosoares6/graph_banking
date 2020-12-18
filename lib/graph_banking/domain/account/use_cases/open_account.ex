defmodule GraphBanking.Account.UseCases.OpenAccount do
  @moduledoc false

  alias GraphBanking.Repository.Accounts

  def apply(args) do
    case args |> Accounts.create() do
      {:error, error} ->
        {:error, error}

      account ->
        {:ok, account}
    end
  end
end
