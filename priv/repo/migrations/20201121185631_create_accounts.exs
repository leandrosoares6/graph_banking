defmodule GraphBanking.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add :uuid, :binary_id, primary_key: true
      add :balance, :float

      timestamps()
    end
  end
end
