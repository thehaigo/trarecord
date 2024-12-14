defmodule Trarecord.FoldersTest do
  use Trarecord.DataCase

  alias Trarecord.Folders

  describe "folders" do
    alias Trarecord.Folders.Folder

    import Trarecord.FoldersFixtures

    @invalid_attrs %{name: nil}

    test "list_folders/0 returns all folders" do
      folder = folder_fixture()
      assert Folders.list_folders() == [folder]
    end

    test "get_folder!/1 returns the folder with given id" do
      folder = folder_fixture()
      assert Folders.get_folder!(folder.id) == folder
    end

    test "create_folder/1 with valid data creates a folder" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Folder{} = folder} = Folders.create_folder(valid_attrs)
      assert folder.name == "some name"
    end

    test "create_folder/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Folders.create_folder(@invalid_attrs)
    end

    test "update_folder/2 with valid data updates the folder" do
      folder = folder_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Folder{} = folder} = Folders.update_folder(folder, update_attrs)
      assert folder.name == "some updated name"
    end

    test "update_folder/2 with invalid data returns error changeset" do
      folder = folder_fixture()
      assert {:error, %Ecto.Changeset{}} = Folders.update_folder(folder, @invalid_attrs)
      assert folder == Folders.get_folder!(folder.id)
    end

    test "delete_folder/1 deletes the folder" do
      folder = folder_fixture()
      assert {:ok, %Folder{}} = Folders.delete_folder(folder)
      assert_raise Ecto.NoResultsError, fn -> Folders.get_folder!(folder.id) end
    end

    test "change_folder/1 returns a folder changeset" do
      folder = folder_fixture()
      assert %Ecto.Changeset{} = Folders.change_folder(folder)
    end
  end
end
