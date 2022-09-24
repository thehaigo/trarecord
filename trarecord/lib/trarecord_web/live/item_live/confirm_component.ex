defmodule TrarecordWeb.ItemLive.ConfirmComponent do
  use TrarecordWeb, :live_component

  alias Trarecord.Items
  alias Phoenix.LiveView.JS

  @impl true
  def update(%{item: _item} = assigns, socket) do
    {:ok, assign(socket, assigns)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    item = Items.get_item!(id)
    {:ok, _} = Items.delete_item(item)

    socket
    |> put_flash(:info, "Item delete successfully")
    |> push_redirect(to: socket.assigns.return_to)
    |> then(&{:noreply, &1})
  end

  defp list_items do
    Items.list_items()
  end
end
