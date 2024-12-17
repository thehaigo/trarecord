defmodule Trarecord.Folders.Folder do
  use Ecto.Schema
  import Ecto.Changeset

  schema "folders" do
    field :name, :string
    belongs_to :user, Trarecord.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(folder, attrs) do
    folder
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name, :user_id])
  end
end
