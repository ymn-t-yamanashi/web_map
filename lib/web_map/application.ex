defmodule WebMap.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    WebMap.EtsMap.init()

    children = [
      WebMapWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:web_map, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: WebMap.PubSub},
      # Start a worker by calling: WebMap.Worker.start_link(arg)
      # {WebMap.Worker, arg},
      # Start to serve requests, typically the last entry
      WebMapWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WebMap.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WebMapWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
