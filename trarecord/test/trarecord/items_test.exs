defmodule Trarecord.ItemsTest do
  use Trarecord.DataCase

  alias Trarecord.Items

  describe "items" do
    alias Trarecord.Items.Item

    import Trarecord.ItemsFixtures

    @invalid_attrs %{category: nil, image: nil, name: nil, status: nil, url: nil}

    test "list_items/0 returns all items" do
      item = item_fixture()
      assert Items.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Items.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      valid_attrs = %{category: "some category", image: "some image", name: "some name", status: true, url: "some url"}

      assert {:ok, %Item{} = item} = Items.create_item(valid_attrs)
      assert item.category == "some category"
      assert item.image == "some image"
      assert item.name == "some name"
      assert item.status == true
      assert item.url == "some url"
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Items.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      update_attrs = %{category: "some updated category", image: "some updated image", name: "some updated name", status: false, url: "some updated url"}

      assert {:ok, %Item{} = item} = Items.update_item(item, update_attrs)
      assert item.category == "some updated category"
      assert item.image == "some updated image"
      assert item.name == "some updated name"
      assert item.status == false
      assert item.url == "some updated url"
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Items.update_item(item, @invalid_attrs)
      assert item == Items.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Items.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Items.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Items.change_item(item)
    end
  end
end
