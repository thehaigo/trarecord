defmodule Trarecord.ItemsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Trarecord.Items` context.
  """

  @doc """
  Generate a item.
  """
  def item_fixture(attrs \\ %{}) do
    {:ok, item} =
      attrs
      |> Enum.into(%{
        category: "some category",
        image: "some image",
        name: "some name",
        status: true,
        url: "some url"
      })
      |> Trarecord.Items.create_item()

    item
  end
end
