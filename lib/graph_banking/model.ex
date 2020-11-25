defmodule GraphBanking.Model do
  @moduledoc """
  Provides functions to extend persist and get schemas from database
  """

  alias GraphBanking.Repo

  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset
      import Ecto.Query

      def find(uuid) do
        Repo.get(__MODULE__, uuid)
      end

      def find_by(conds) do
        Repo.get_by(__MODULE__, conds)
      end

      def create(attrs) do
        attrs
        |> changeset()
        |> Repo.insert()
      end

      def changeset(attrs) do
        __MODULE__.__struct__()
        |> changeset(attrs)
      end
    end
  end
end
