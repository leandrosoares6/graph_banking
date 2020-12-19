defmodule GraphBankingWeb.Resolvers.Transfer do
  @moduledoc """
  Provides a resolver functions to manager Transfers
  """

  alias GraphBanking.Account.UseCases.TransferMoney

  def create(_parent, args, _resolutions) do
    args
    |> TransferMoney.apply()
  end
end
