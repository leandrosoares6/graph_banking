defmodule GraphBanking.Repository.Transfers do
  @moduledoc false
  alias GraphBanking.Repo
  alias GraphBanking.Model.Transfer
  alias GraphBanking.Repository.Accounts
  import Ecto.Changeset, only: [change: 2]

  def create(sender, address, transfer) do
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

  def cast_to_model(args) do
    args
    |> Transfer.create()
  end

  def cast_to_schema(transfer_model) do
    transfer_model
    |> to_persistence_model()

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
