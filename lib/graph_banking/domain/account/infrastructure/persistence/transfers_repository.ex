defmodule GraphBanking.Domain.Account.Infrastructure.Persistence.TransfersRepository do
  @moduledoc false
  alias GraphBanking.Repo
  alias GraphBanking.Domain.Account.Entities.Account
  alias GraphBanking.Domain.Account.Repositories.BTransfersRepository
  import Ecto.Changeset, only: [change: 2]

  @behaviour BTransfersRepository

  @impl BTransfersRepository
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
end
