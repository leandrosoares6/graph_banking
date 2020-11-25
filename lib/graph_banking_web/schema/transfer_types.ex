defmodule GraphBankingWeb.Schema.TransferTypes do
  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  alias GraphBankingWeb.{Data, Resolvers}

  @desc "A transfer object"
  object :transfer do
    field :uuid, :string
    field :sender, :account, resolve: dataloader(Data)
    field :address, :string
    field :amount, :float
    field :when, :string
  end

  object :transfer_queries do
    @desc "Get all transfers for a specific account"
    field :account_transfers, list_of(:transfer) do
      arg(:sender, non_null(:string))
      resolve(&Resolvers.TransferResolver.list/3)
    end
  end

  object :transfer_mutations do
    @desc "Transfer money between accounts"
    field :transfer_money, type: :transfer do
      arg(:sender, non_null(:string))
      arg(:address, non_null(:string))
      arg(:amount, non_null(:float))
      resolve(&Resolvers.TransferResolver.create/3)
    end
  end
end
