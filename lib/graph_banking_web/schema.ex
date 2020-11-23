defmodule GraphBankingWeb.Schema do
  use Absinthe.Schema

  object :account do
    field :uuid, :string
    field :balance, :float
  end

  query do
    field :accounts, list_of(:account) do
      resolve(fn _parent, _args, _context ->
        {:ok, GraphBanking.Content.list_accounts()}
      end)
    end
  end

  mutation do
    @desc "Open a account"
    field :open_account, type: :account do
      arg :balance, non_null(:float)
      resolve &GraphBanking.Content.create_account/2
    end
  end
end
