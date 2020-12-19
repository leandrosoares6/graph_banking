defmodule GraphBanking.Repository.Transfers do
  @moduledoc false
  alias GraphBanking.Repo
  alias GraphBanking.Model.Transfer
  alias GraphBanking.Repository.Accounts
  import Ecto.Changeset, only: [change: 2]

  def create(transfer_model) do
    sender = transfer_model.sender |> Accounts.get()
    address = transfer_model.address |> Accounts.get()
    transfer = transfer_model |> to_persistence_model()

    case sender do
      nil ->
        {:error, "Sender not found."}

      _ ->
        case address do
          nil -> {:error, "Address not found."}
          _ -> transfer_money(sender, address, transfer)
        end
    end
  end

  defp transfer_money(sender, address, transfer) do
    amount = transfer.amount
    sender_balance = Accounts.debit(sender, amount)
    address_balance = Accounts.credit(address, amount)

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

  def create_model(args) do
    insert = args |> Transfer.create()

    case insert do
      {:error, message} ->
        {:error, message}

      model_transfer ->
        model_transfer
    end
  end

  defp to_persistence_model(domain_model) do
    %GraphBanking.Persistence.Transfer{
      uuid: domain_model.uuid,
      sender: domain_model.sender,
      address: domain_model.address,
      amount: domain_model.amount,
      when: domain_model.when
    }
  end
end
