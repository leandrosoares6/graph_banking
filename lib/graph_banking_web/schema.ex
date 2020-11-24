defmodule GraphBankingWeb.Schema do
  use Absinthe.Schema
  import AbsintheErrorPayload.Payload
  import_types AbsintheErrorPayload.ValidationMessageTypes

  payload_object(:account_payload, :account)
  payload_object(:transfer_payload, :transfer)

  object :account do
    field :uuid, :string
    field :balance, :float
  end

  object :transfer do
    field :uuid, :string
    field :sender, :string
    field :address, :string
    field :amount, :float
    field :when, :string
  end

  query do
    @desc "List accounts"
    field :accounts, list_of(:account) do
      resolve(fn _parent, _args, _context ->
        {:ok, GraphBanking.Content.list_accounts()}
      end)
    end
  end

  mutation do
    @desc "Open a account"
    field :open_account, type: :account_payload do
      arg :balance, non_null(:float)
      resolve &GraphBanking.Content.create_account/2
      middleware &build_payload/2
    end

    @desc "Transfer money between accounts"
    field :transfer_money, type: :transfer do
      arg :sender, non_null(:string)
      arg :address, non_null(:string)
      arg :amount, non_null(:float)
      resolve &GraphBanking.Content.transfer_money/2
    end
  end
end
