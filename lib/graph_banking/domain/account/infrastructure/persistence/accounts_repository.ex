defmodule GraphBanking.Domain.Account.Infrastructure.Persistence.AccountsRepository do
  @moduledoc false

  alias GraphBanking.Repo
  alias GraphBanking.Domain.Account.Entities.Account
  alias GraphBanking.Domain.Account.Repositories.BAccountsRepository
  alias GraphBanking.Domain.Account.Infrastructure.Persistence.Account, as: AccountSchema
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
        |> AccountSchema.to_persistence_model()
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
      from(a in AccountSchema,
        where: a.uuid == ^uuid
      )

    case query |> Repo.one() do
      nil -> nil
      model -> model
    end
  end
end
