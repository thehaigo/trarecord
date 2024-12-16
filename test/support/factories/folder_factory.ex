defmodule Trarecord.FolderFactory do
  @moduledoc """
  Folder Factory for ExMachina
  """
  defmacro __using__(_opts) do
    alias Trarecord.Folders.Folder

    quote do
      def folder_factory do
        %Folder{
          name: "new folder",
          user: build(:user)
        }
      end
    end
  end
end
