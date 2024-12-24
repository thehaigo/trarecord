defmodule TrarecordWeb.FolderLive.Index do
  use TrarecordWeb, :live_view

  alias Trarecord.Folders
  alias Trarecord.Folders.Folder

  @impl true
  def mount(_params, _session, socket) do
    user = socket.assigns.current_user
    {:ok, stream(socket, :folders, Folders.list_folders(user.id))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Folder")
    |> assign(:folder, Folders.get_folder!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Folder")
    |> assign(:folder, %Folder{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Folders")
    |> assign(:folder, nil)
  end

  defp apply_action(socket, :delete, %{"id" => id}) do
    socket
    |> assign(:page_title, "Delete Folder")
    |> assign(:folder, Folders.get_folder!(id))
  end

  @impl true
  def handle_info({TrarecordWeb.FolderLive.FormComponent, {:saved, folder}}, socket) do
    {:noreply, stream_insert(socket, :folders, folder, at: -1)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    folder = Folders.get_folder!(id)
    {:ok, _} = Folders.delete_folder(folder)

    socket
    |> put_flash(:info, "Folder deleted successfully")
    |> push_patch(to: ~p"/folders")
    |> stream_delete(:folders, folder)
    |> then(&{:noreply, &1})
  end
end
