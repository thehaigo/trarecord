defmodule TrarecordWeb.PageController do
  use TrarecordWeb, :controller
  alias Trarecord.Accounts.User

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def index(conn, _params) do
    redirect_to(conn, conn.assigns.current_user)
  end

  defp redirect_to(conn, %User{}) do
    redirect(conn, to: ~p"/users/settings")
  end

  defp redirect_to(conn, nil) do
    redirect(conn, to: ~p"/users/log_in")
  end
end
