defmodule TrarecordWeb.FolderLive.Show do
  use TrarecordWeb, :live_view

  alias Trarecord.Folders

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:folder, Folders.get_folder!(id))}
  end

  defp page_title(:show), do: "Show Folder"
  defp page_title(:edit), do: "Edit Folder"
end
