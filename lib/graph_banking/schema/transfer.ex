defmodule GraphBanking.Schema.Transfer do
  @moduledoc """
  Extends functions from models for Transfer schema
  """

  use GraphBanking.Model
  alias GraphBanking.Schema.Account

  @primary_key {:uuid, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "transfers" do
    field :address, :binary_id
    field :amount, :float
    field :when, :utc_datetime_usec, default: DateTime.utc_now()

    belongs_to :account, Account,
      references: :uuid,
      foreign_key: :sender,
      type: :binary_id
  end

  @doc false
  def changeset(transfer, attrs) do
    transfer
    |> cast(attrs, [:sender, :address, :amount])
    |> validate_required([:sender, :address, :amount])
    |> validate_number(:amount, greater_than: 0)
    |> foreign_key_constraint(:sender)
    |> sender_address_must_be_dif
  end

  def sender_address_must_be_dif(changeset) do
    case changeset.valid? do
      true ->
        # IO.inspect changeset
        sender = changeset.changes.sender
        address = changeset.changes.address

        case String.normalize(sender, :nfd) == String.normalize(address, :nfd) do
          true -> add_error(changeset, :sender, "You cannot make a transfer to yourself")
          _ -> changeset
        end

      _ ->
        changeset
    end
  end
end
