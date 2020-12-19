defmodule GraphBankingWeb.Types.Transfer do
  @moduledoc """
  Provides a objects, mutations and subscriptions related
  """

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

  object :transfer_mutations do
    @desc "Transfer money between accounts"
    field :transfer_money, type: :transfer do
      arg(:sender, non_null(:string))
      arg(:address, non_null(:string))
      arg(:amount, non_null(:float))
      resolve(&Resolvers.Transfer.create/3)
    end
  end
end
