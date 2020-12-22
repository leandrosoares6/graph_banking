defmodule GraphBanking.Domain.Account.Infrastructure.Persistence.Transfer do
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

  def to_persistence_model(domain_model) do
    %__MODULE__{
      uuid: domain_model.uuid,
      sender: domain_model.sender,
      address: domain_model.address,
      amount: domain_model.amount,
      when: domain_model.when
    }
  end
end
