defmodule GraphBanking.Content do
  alias GraphBanking.Repo
  alias GraphBanking.Schema.Account

  def list_accounts() do
    Repo.all(Account)
  end

  def create_account(attrs, _info) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert
  end
end