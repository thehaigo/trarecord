defmodule Trarecord.Items.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :category, :string
    field :image, :string
    field :name, :string
    field :status, :boolean, default: false
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:name, :url, :image, :category, :status])
    |> validate_required([:name, :url, :image, :category, :status])
  end
end
