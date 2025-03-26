defmodule Todoest.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TodoestWeb.Telemetry,
      Todoest.Repo,
      {DNSCluster, query: Application.get_env(:todoest, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Todoest.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Todoest.Finch},
      # Start a worker by calling: Todoest.Worker.start_link(arg)
      # {Todoest.Worker, arg},
      # Start to serve requests, typically the last entry
      TodoestWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Todoest.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TodoestWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
