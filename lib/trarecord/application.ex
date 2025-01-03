defmodule Trarecord.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    File.mkdir_p!(Trarecord.config_dir())

    children = [
      TrarecordWeb.Telemetry,
      Trarecord.Repo,
      {DNSCluster, query: Application.get_env(:trarecord, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Trarecord.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Trarecord.Finch},
      # Start a worker by calling: Trarecord.Worker.start_link(arg)
      # {Trarecord.Worker, arg},
      # Start to serve requests, typically the last entry
      TrarecordWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    :session = :ets.new(:session, [:named_table, :public, read_concurrency: true])
    opts = [strategy: :one_for_one, name: Trarecord.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TrarecordWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
