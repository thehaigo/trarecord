defmodule TrarecordWeb.PageControllerTest do
  use TrarecordWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Welcome"
  end
end
