defmodule GraphBankingWeb.Schema do
  @moduledoc """
  Import schema types and define all queries and mutations
  """

  use Absinthe.Schema

  alias GraphBankingWeb.Data

  import_types(Absinthe.Type.Custom)
  import_types(GraphBankingWeb.Types.Account)
  import_types(GraphBankingWeb.Types.Transfer)

  query do
    import_fields(:account_queries)
  end

  mutation do
    import_fields(:account_mutations)
    import_fields(:transfer_mutations)
  end

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Data, Data.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
