defmodule GraphBanking.Persistence.Account do
  @moduledoc false

  use Ecto.Schema
  alias GraphBanking.Persistence.Transfer

  @primary_key {:uuid, :string, autogenerate: false}
  @foreign_key_type :string
  schema "accounts" do
    field :balance, :float
    has_many :transfers, Transfer, foreign_key: :sender

    timestamps()
  end
end
