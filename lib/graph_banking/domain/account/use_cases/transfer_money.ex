defmodule GraphBanking.Account.UseCases.TransferMoney do
  @moduledoc false

  alias GraphBanking.Repository.Transfers

  def apply(args) do
    transfer_model = args |> Transfers.create_model()

    case transfer_model do
      {:error, error} -> {:error, error}
      transfer -> transfer |> Transfers.create()
    end
  end
end
