defmodule Trarecord.Folders.Folder do
  use Ecto.Schema
  import Ecto.Changeset

  schema "folders" do
    field :name, :string
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(folder, attrs) do
    folder
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
