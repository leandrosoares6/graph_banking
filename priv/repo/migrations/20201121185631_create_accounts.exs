defmodule GraphBanking.Repo.Migrations.CreateAccounts do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add :uuid, :string, primary_key: true
      add :balance, :float

      timestamps()
    end
  end
end
