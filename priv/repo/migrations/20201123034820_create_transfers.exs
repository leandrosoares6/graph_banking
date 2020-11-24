defmodule GraphBanking.Repo.Migrations.CreateTransfers do
  use Ecto.Migration

  def change do
    create table(:transfers, primary_key: false) do
      add :uuid, :binary_id, primary_key: true
      add :sender, references(:accounts, column: :uuid, type: :binary_id)
      add :address, :binary_id
      add :amount, :float
      add :when, :utc_datetime_usec
    end
  end
end
