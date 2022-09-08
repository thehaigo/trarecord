defmodule Trarecord.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Trarecord.Repo,
      # Start the Telemetry supervisor
      TrarecordWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Trarecord.PubSub},
      # Start the Endpoint (http/https)
      TrarecordWeb.EndpointWeb
      # Start a worker by calling: Trarecord.Worker.start_link(arg)
      # {Trarecord.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Trarecord.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TrarecordWeb.EndpointWeb.config_change(changed, removed)
    :ok
  end
end
