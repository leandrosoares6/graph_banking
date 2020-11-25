defmodule GraphBankingWeb.Resolvers.AccountResolver do
  alias GraphBanking.Schema.Account

  def list(_parent, _args, _resolutions) do
    {:ok, Account.all()}
  end

  def show(_parent, args, _resolutions) do
    case Account.find(args[:uuid]) do
      nil -> {:error, "Not found"}
      account -> {:ok, account}
    end
  end

  def create(_parent, args, _resolutions) do
    args
    |> Account.create()
    |> case do
      {:ok, post} ->
        {:ok, post}

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