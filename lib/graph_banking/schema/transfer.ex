defmodule GraphBanking.Schema.Transfer do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:uuid, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "transfers" do
    field :address, :binary_id
    field :amount, :float
    field :when, :utc_datetime_usec
    belongs_to :account, GraphBanking.Schema.Account,
      references: :uuid,
      foreign_key: :account_id,
      type: :binary_id


    timestamps()
  end

  @doc false
  def changeset(transfer, attrs) do
    transfer
    |> cast(attrs, [:address, :amount, :when])
    |> validate_required([:address, :amount, :when])
  end
end
