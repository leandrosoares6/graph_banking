defmodule GraphBanking.Repository.Transfers do
  @moduledoc false
  alias GraphBanking.Repo
  alias GraphBanking.Model.Account
  alias GraphBanking.Model.Transfer
  import Ecto.Changeset, only: [change: 2]

  def create(sender, address, transfer) do
    amount = transfer.amount
    sender_balance = Account.debit(sender, amount)
    address_balance = Account.credit(address, amount)

    sender_changeset =
      sender
      |> change(%{balance: sender_balance})

    address_changeset =
      address
      |> change(%{balance: address_balance})

    case sender_balance do
      {:error, error} ->
        {:error, error}

      _ ->
        Repo.transaction(fn ->
          Repo.update!(sender_changeset)
          Repo.update!(address_changeset)
          Repo.insert!(transfer)
        end)
    end
  end

  def cast_to_model(args) do
    args
    |> Transfer.create()
  end

  def cast_to_schema(transfer_model) do
    transfer_model
    |> GraphBanking.Persistence.Transfer.to_persistence_model()
  end
end
