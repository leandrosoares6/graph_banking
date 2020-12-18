defmodule GraphBankingWeb.Resolvers.Account do
  @moduledoc """
  Provides a resolver functions to manager Accounts
  """

  alias GraphBanking.Account.UseCases.OpenAccount
  alias GraphBanking.Account.UseCases.GetAccount

  def show(_parent, args, _resolutions) do
    args
    |> GetAccount.apply()
  end

  def create(_parent, args, _resolutions) do
    args
    |> OpenAccount.apply()
  end
end
