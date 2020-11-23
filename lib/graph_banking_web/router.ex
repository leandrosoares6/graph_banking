defmodule GraphBankingWeb.Router do
  use GraphBankingWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", GraphBankingWeb do
    pipe_through :api
  end

  forward "/graphiql", Absinthe.Plug.GraphiQL, schema: GraphBankingWeb.Schema
  forward "/", Absinthe.Plug, schema: GraphBankingWeb.Schema
  
  # if Mix.env() in [:dev, :test] do
  #   import Phoenix.LiveDashboard.Router

  #   scope "/" do
  #     pipe_through [:fetch_session, :protect_from_forgery]
  #     live_dashboard "/dashboard", metrics: GraphBankingWeb.Telemetry
  #   end
  # end
end
