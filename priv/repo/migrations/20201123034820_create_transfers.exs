defmodule GraphBanking.Repo.Migrations.CreateTransfers do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:transfers, primary_key: false) do
      add :uuid, :string, primary_key: true
      add :sender, references(:accounts, column: :uuid, type: :string)
      add :address, :string
      add :amount, :float
      add :when, :utc_datetime_usec
    end
  end
end
