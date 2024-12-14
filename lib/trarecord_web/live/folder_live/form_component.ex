defmodule TrarecordWeb.FolderLive.FormComponent do
  use TrarecordWeb, :live_component

  alias Trarecord.Folders

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage folder records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="folder-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Folder</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{folder: folder} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Folders.change_folder(folder))
     end)}
  end

  @impl true
  def handle_event("validate", %{"folder" => folder_params}, socket) do
    changeset = Folders.change_folder(socket.assigns.folder, folder_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"folder" => folder_params}, socket) do
    save_folder(socket, socket.assigns.action, folder_params)
  end

  defp save_folder(socket, :edit, folder_params) do
    case Folders.update_folder(socket.assigns.folder, folder_params) do
      {:ok, folder} ->
        notify_parent({:saved, folder})

        {:noreply,
         socket
         |> put_flash(:info, "Folder updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_folder(socket, :new, folder_params) do
    case Folders.create_folder(folder_params) do
      {:ok, folder} ->
        notify_parent({:saved, folder})

        {:noreply,
         socket
         |> put_flash(:info, "Folder created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
