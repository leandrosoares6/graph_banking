defmodule GraphBanking.Domain.Account.Entities.Account do
  @moduledoc false

  @enforce_keys [:balance]
  defstruct uuid: nil,
            balance: nil

  def create(%{balance: balance}) do
    case {balance} do
      {balance} when balance >= 0 ->
        uuid = UUID.uuid4()
        %__MODULE__{uuid: uuid, balance: balance}

      {_} ->
        {:error, "Balance must be greater than or equal to 0."}
    end
  end

  def create(_), do: {:error, "Invalid params to create Account."}

  def debit(account_schema, amount) do
    account = account_schema |> to_domain_model()

    case amount > account.balance do
      true ->
        {:error, "There is not enough balance to perform this operation."}

      _ ->
        %__MODULE__{account | balance: account.balance - amount}
        |> Map.get(:balance)
    end
  end

  def credit(account_schema, amount) do
    account = account_schema |> to_domain_model()

    %__MODULE__{account | balance: account.balance + amount}
    |> Map.get(:balance)
  end

  def to_domain_model(persistence_model) do
    %__MODULE__{
      uuid: persistence_model.uuid,
      balance: persistence_model.balance
    }
  end
end
