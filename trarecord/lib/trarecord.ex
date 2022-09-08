defmodule Trarecord do
  @moduledoc """
  Trarecord keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  @app Mix.Project.config()[:app]
  def start(:normal, []) do
    {:ok, sup} = Supervisor.start_link([Trarecord.Repo], name: __MODULE__, strategy: :one_for_one)
    {:ok, _} = Supervisor.start_child(sup, TrarecordWeb.DesktopSup)

    {:ok, _} =
      Supervisor.start_child(sup, {
        Desktop.Window,
        [
          app: @app,
          id: TrerecordWindow,
          title: "TrerecordApp",
          size: {600, 500},
          url: &TrarecordWeb.Endpoint.url/0
        ]
      })
  end
end
