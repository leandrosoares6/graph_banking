defmodule GraphBanking.Account.UseCases.TransferMoney do
  @moduledoc false

  alias GraphBanking.Repository.Transfers
  alias GraphBanking.Repository.Accounts

  def apply(args) do
    transfer_model = args |> Transfers.cast_to_model()

    case transfer_model do
      {:error, error} -> {:error, error}
      transfer -> transfer |> create()
    end
  end

  defp create(transfer_model) do
    sender = transfer_model.sender |> Accounts.get()
    address = transfer_model.address |> Accounts.get()
    transfer = transfer_model |> Transfers.cast_to_schema()

    case sender do
      nil ->
        {:error, "Sender not found."}

      _ ->
        case address do
          nil -> {:error, "Address not found."}
          _ -> Transfers.create(sender, address, transfer)
        end
    end
  end
end
