defmodule GraphBanking.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    opts = [strategy: :one_for_one, name: GraphBanking.Supervisor]
    Supervisor.start_link(get_children(), opts)
  end

  def config_change(changed, _new, removed) do
    GraphBankingWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp get_children do
    case Mix.env() do
      :test ->
        []

      _ ->
        [
          GraphBanking.Repo,
          GraphBankingWeb.Telemetry,
          {Phoenix.PubSub, name: GraphBanking.PubSub},
          GraphBankingWeb.Endpoint
        ]
    end
  end
end
