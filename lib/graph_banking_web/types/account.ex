defmodule GraphBankingWeb.Types.Account do
  @moduledoc """
  Provides a objects, mutations and subscriptions related
  """

  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers, only: [dataloader: 3]

  alias GraphBankingWeb.{Data, Resolvers}

  @desc "Account bank object"
  object :account do
    field :uuid, :string
    field :balance, :float

    field :transactions, list_of(:transfer),
      resolve: dataloader(Data, :transfers, args: %{order_by: :uuid})
  end

  object :account_queries do
    @desc "Get a specific account"
    field :account, :account do
      arg(:uuid, non_null(:string))
      resolve(&Resolvers.Account.show/3)
    end
  end

  object :account_mutations do
    @desc "Open a account"
    field :open_account, type: :account do
      arg(:balance, non_null(:float))
      resolve(&Resolvers.Account.create/3)
    end
  end
end
