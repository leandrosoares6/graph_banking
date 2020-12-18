defmodule GraphBanking.Persistence.Transfer do
  @moduledoc false

  use Ecto.Schema
  alias GraphBanking.Persistence.Account

  @primary_key {:uuid, :string, autogenerate: false}
  @foreign_key_type :string
  schema "transfers" do
    field :address, :string
    field :amount, :float
    field :when, :utc_datetime_usec

    belongs_to :account, Account,
      references: :uuid,
      foreign_key: :sender,
      type: :string
  end
end
