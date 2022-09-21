defmodule TrarecordWeb.HomeLive do
  use TrarecordWeb, :live_view
  alias TrarecordWeb.Components.Navigation

  @impl true
  def mount(_args, _session, socket) do
    socket
    |> assign(:title, "Home")
    |> then(&{:ok, &1})
  end
end
