defmodule GraphBanking.Schema.Transfer do
  # use Ecto.Schema
  use GraphBanking.Model
  # import Ecto.Changeset
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
    |> foreign_key_constraint(:sender)
  end
end
