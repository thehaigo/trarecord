defmodule TrarecordWeb.FolderLiveTest do
  use TrarecordWeb.ConnCase

  import Phoenix.LiveViewTest
  import Trarecord.FoldersFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_folder(_) do
    folder = folder_fixture()
    %{folder: folder}
  end

  describe "Index" do
    setup [:create_folder]

    test "lists all folders", %{conn: conn, folder: folder} do
      {:ok, _index_live, html} = live(conn, ~p"/folders")

      assert html =~ "Listing Folders"
      assert html =~ folder.name
    end

    test "saves new folder", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/folders")

      assert index_live |> element("a", "New Folder") |> render_click() =~
               "New Folder"

      assert_patch(index_live, ~p"/folders/new")

      assert index_live
             |> form("#folder-form", folder: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#folder-form", folder: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/folders")

      html = render(index_live)
      assert html =~ "Folder created successfully"
      assert html =~ "some name"
    end

    test "updates folder in listing", %{conn: conn, folder: folder} do
      {:ok, index_live, _html} = live(conn, ~p"/folders")

      assert index_live |> element("#folders-#{folder.id} a", "Edit") |> render_click() =~
               "Edit Folder"

      assert_patch(index_live, ~p"/folders/#{folder}/edit")

      assert index_live
             |> form("#folder-form", folder: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#folder-form", folder: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/folders")

      html = render(index_live)
      assert html =~ "Folder updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes folder in listing", %{conn: conn, folder: folder} do
      {:ok, index_live, _html} = live(conn, ~p"/folders")

      assert index_live |> element("#folders-#{folder.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#folders-#{folder.id}")
    end
  end

  describe "Show" do
    setup [:create_folder]

    test "displays folder", %{conn: conn, folder: folder} do
      {:ok, _show_live, html} = live(conn, ~p"/folders/#{folder}")

      assert html =~ "Show Folder"
      assert html =~ folder.name
    end

    test "updates folder within modal", %{conn: conn, folder: folder} do
      {:ok, show_live, _html} = live(conn, ~p"/folders/#{folder}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Folder"

      assert_patch(show_live, ~p"/folders/#{folder}/show/edit")

      assert show_live
             |> form("#folder-form", folder: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#folder-form", folder: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/folders/#{folder}")

      html = render(show_live)
      assert html =~ "Folder updated successfully"
      assert html =~ "some updated name"
    end
  end
end
