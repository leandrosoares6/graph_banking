defmodule GraphBanking.Repository.Accounts do
  @moduledoc false
  alias GraphBanking.Repo
  alias GraphBanking.Model.Account
  import Ecto.Query

  def create(balance) do
    insert = balance |> Account.create()

    case insert do
      {:error, message} ->
        {:error, message}

      model_account ->
        model_account
        |> to_persistence_model
        |> Repo.insert()
        |> case do
          {:error, change} -> {:error, change.message}
          {:ok, model} -> model |> to_domain_model
        end
    end
  end

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

  def debit(schema, amount) do
    model = schema |> to_domain_model()
    balance = Account.debit(model, amount)

    case balance do
      {:error, error} -> {:error, error}
      balance -> balance
    end
  end

  def credit(schema, amount) do
    model = schema |> to_domain_model()
    Account.credit(model, amount)
  end

  defp to_domain_model(persistence_model) do
    %GraphBanking.Model.Account{
      uuid: persistence_model.uuid,
      balance: persistence_model.balance
    }
  end

  defp to_persistence_model(domain_model) do
    %GraphBanking.Persistence.Account{
      uuid: domain_model.uuid,
      balance: domain_model.balance
    }
  end
end
