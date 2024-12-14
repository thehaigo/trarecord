defmodule Trarecord.FoldersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Trarecord.Folders` context.
  """

  @doc """
  Generate a folder.
  """
  def folder_fixture(attrs \\ %{}) do
    {:ok, folder} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Trarecord.Folders.create_folder()

    folder
  end
end
