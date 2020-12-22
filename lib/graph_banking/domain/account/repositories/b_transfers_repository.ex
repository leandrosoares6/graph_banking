defmodule GraphBanking.Domain.Account.Repositories.BTransfersRepository do
  @moduledoc false
  alias GraphBanking.Domain.Account.Entities.Transfer
  alias GraphBanking.Domain.Account.Infrastructure.Persistence.Account, as: AccountSchema
  alias GraphBanking.Domain.Account.Infrastructure.Persistence.Transfer, as: TransferSchema
  alias GraphBanking.Domain.Account.Infrastructure.Persistence.TransfersRepository, as: Transfers

  @callback create(
              sender :: %AccountSchema{},
              address :: %AccountSchema{},
              transfer :: %TransferSchema{}
            ) :: {:ok, any()} | {:error, String.t()}

  def create(sender, address, transfer, adapter_type \\ :ecto) do
    repository_impl = repository_for(adapter_type)
    repository_impl.create(sender, address, transfer)
  end

  defp repository_for(:ecto), do: Transfers

  def cast_to_model(args) do
    args
    |> Transfer.create()
  end

  def cast_to_schema(transfer_model) do
    transfer_model
    |> TransferSchema.to_persistence_model()
  end
end
