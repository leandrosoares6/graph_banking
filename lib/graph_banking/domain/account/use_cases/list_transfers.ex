defmodule GraphBanking.Account.UseCases.ListTransfers do
  @moduledoc false

  alias GraphBanking.Repository.Transfers

  def apply(args) do
    args |> Transfers.list()
  end
end
