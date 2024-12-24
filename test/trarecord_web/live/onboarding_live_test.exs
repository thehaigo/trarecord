defmodule TrarecordWeb.OnboardingLiveTest do
  use TrarecordWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  describe "start onbarding" do
    setup %{conn: conn} do
      %{conn: log_in_user(conn, insert(:user))}
    end

    test "render onboarding page", %{conn: conn} do
      {:ok, _lv, html} = live(conn, ~p"/onboarding")

      assert html =~ "Let&#39;s gather where we want to go."
      assert html =~ "next"
    end

    test "finish onboarding and redirect /", %{conn: conn} do
      {:ok, lv, _html} = live(conn, ~p"/onboarding")

      assert lv
             |> element("p", "next")
             |> render_click() =~ "Let&#39;s organize them in folders."

      assert lv
             |> element("p", "next")
             |> render_click() =~ "Record your travel."

      assert lv
             |> element("p", "finish")
             |> render_click()
             |> follow_redirect(conn, "/")
    end
  end
end
