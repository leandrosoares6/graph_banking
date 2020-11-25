defmodule GraphBankingWeb.Schema do
  use Absinthe.Schema

  alias GraphBankingWeb.Data

  import_types(Absinthe.Type.Custom)
  import_types(GraphBankingWeb.Schema.AccountTypes)
  import_types(GraphBankingWeb.Schema.TransferTypes)

  query do
    import_fields(:account_queries)
    import_fields(:transfer_queries)
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
end
