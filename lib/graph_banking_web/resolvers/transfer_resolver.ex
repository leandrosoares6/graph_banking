defmodule GraphBankingWeb.Resolvers.TransferResolver do
  alias GraphBanking.Repo
  alias GraphBanking.Schema.{Account, Transfer}

  def list(_parent, args, _resolutions) do
    account =
      args[:sender]
      |> Account.find()
      |> Repo.preload(:transfers)

    {:ok, account.transfers}
  end

  def create(_parent, args, _resolutions) do
    args
    |> Transfer.create()
    |> case do
      {:ok, transfer} ->
        {:ok, transfer}

      {:error, changeset} ->
        {:error, extract_error_msg(changeset)}
    end
  end

  defp extract_error_msg(changeset) do
    changeset.errors
    |> Enum.map(fn {field, {error, _details}} ->
      [
        field: field,
        message: String.capitalize(error)
      ]
    end)
  end
end