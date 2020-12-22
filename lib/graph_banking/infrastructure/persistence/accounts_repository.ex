defmodule GraphBanking.Repository.Accounts do
  @moduledoc false

  alias GraphBanking.Repo
  alias GraphBanking.Model.Account
  alias GraphBanking.Repository.BAccountsRepository
  import Ecto.Query

  @behaviour BAccountsRepository

  @impl BAccountsRepository
  def create(balance) do
    insert = balance |> Account.create()

    case insert do
      {:error, message} ->
        {:error, message}

      model_account ->
        model_account
        |> GraphBanking.Persistence.Account.to_persistence_model()
        |> Repo.insert()
        |> case do
          {:error, change} -> {:error, change.message}
          {:ok, account_schema} -> account_schema |> Account.to_domain_model()
        end
    end
  end

  @impl BAccountsRepository
  def get(uuid) do
    query =
      from(a in GraphBanking.Persistence.Account,
        where: a.uuid == ^uuid
      )

    case query |> Repo.one() do
      nil -> nil
      model -> model
    end
  end
end
