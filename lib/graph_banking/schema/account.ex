defmodule GraphBanking.Schema.Account do
  @moduledoc """
  Extends functions from models for Account schema
  """

  use GraphBanking.Model
  alias GraphBanking.Repo
  alias GraphBanking.Schema.Transfer

  @primary_key {:uuid, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    field :balance, :float
    has_many :transfers, Transfer, foreign_key: :sender

    timestamps()
  end

  def all do
    Repo.all(from row in __MODULE__, order_by: [desc: row.uuid])
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:balance])
    |> validate_number(:balance, greater_than_or_equal_to: 0)
    |> validate_required([:balance])
  end
end
