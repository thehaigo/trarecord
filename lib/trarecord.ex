defmodule Trarecord do
  use Application

  @env Mix.env()
  def config_dir() do
    case(@env) do
      :test ->
        "tmp"

      _ ->
        {path, _} =
          Code.eval_string("Path.join([Desktop.OS.home(), dir, app])",
            dir: ".config",
            app: "trarecord"
          )

        path
    end
  end

  def token_path() do
    config_dir() <> "/token"
  end

  @app Mix.Project.config()[:app]
  def start(:normal, []) do
    File.mkdir_p!(config_dir())

    :session = :ets.new(:session, [:named_table, :public, read_concurrency: true])

    children = [
      Trarecord.Repo,
      {Phoenix.PubSub, name: Trarecord.PubSub},
      {Finch, name: Trarecord.Finch},
      TrarecordWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Trarecord.Supervisor]
    {:ok, sup} = Supervisor.start_link(children, opts)

    {:ok, {_ip, port}} = Bandit.PhoenixAdapter.server_info(TrarecordWeb.Endpoint, :http)

    {:ok, _} =
      Supervisor.start_child(sup, {
        Desktop.Window,
        [
          app: @app,
          id: TrarecordWindow,
          title: "trarecord",
          size: {400, 800},
          url: "http://localhost:#{port}"
        ]
      })
  end

  def config_change(changed, _new, removed) do
    TrarecordWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
