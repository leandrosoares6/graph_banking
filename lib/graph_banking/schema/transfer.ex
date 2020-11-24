defmodule GraphBanking.Schema.Transfer do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:uuid, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "transfers" do
    field :address, :binary_id
    field :amount, :float
    field :when, :utc_datetime_usec, default: DateTime.utc_now()
    belongs_to :account, GraphBanking.Schema.Account,
      references: :uuid,
      foreign_key: :sender,
      type: :binary_id
  end

  @doc false
  def changeset(transfer, attrs) do
    transfer
    |> cast(attrs, [:sender, :address, :amount])
    |> validate_required([:sender, :address, :amount])
  end
end
