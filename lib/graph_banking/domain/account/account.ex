defmodule GraphBanking.Model.Account do
  @moduledoc false

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

  def debit(account, amount) do
    case amount > account.balance do
      true ->
        {:error, "There is not enough balance to perform this operation."}

      _ ->
        %__MODULE__{account | balance: account.balance - amount}
        |> Map.get(:balance)
    end
  end

  def credit(account, amount) do
    %__MODULE__{account | balance: account.balance + amount}
    |> Map.get(:balance)
  end
end
