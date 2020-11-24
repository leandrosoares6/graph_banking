defmodule GraphBanking.Schema.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:uuid, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    field :balance, :float
    has_many :transfers, GraphBanking.Schema.Transfer

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:balance])
    |> validate_number(:balance, greater_than_or_equal_to: 0)
    |> validate_required([:balance])
  end
end
