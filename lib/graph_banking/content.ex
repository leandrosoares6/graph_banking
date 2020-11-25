defmodule GraphBanking.Content do
  alias GraphBanking.Repo
  alias GraphBanking.Schema.Account
  alias GraphBanking.Schema.Transfer

  def list_accounts() do
    Repo.all(Account)
  end

  def find_account(uuid) do
    Repo.get!(Account, uuid)
    |> Repo.preload(:transfers)
  end

  def create_account(attrs, _info) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert()
  end

  def transfer_money(attrs, _info) do
    %Transfer{}
    |> Transfer.changeset(attrs)
    |> Repo.insert()
  end
end
