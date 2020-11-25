defmodule GraphBanking.Schema.Transfer do
  use GraphBanking.Model
  alias GraphBanking.Repo
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

  def all do
    Repo.all(from row in __MODULE__, order_by: [desc: row.uuid])
  end

  @doc false
  def changeset(transfer, attrs) do
    transfer
    |> cast(attrs, [:sender, :address, :amount])
    |> validate_required([:sender, :address, :amount])
    |> validate_number(:sender, not_equal_to: :address)
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
