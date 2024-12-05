defmodule TrarecordWeb.PageController do
  use TrarecordWeb, :controller
  alias Trarecord.Accounts.User

  def index(conn, _params) do
    redirect_to(conn, conn.assigns.current_user)
  end

  defp redirect_to(conn, %User{}) do
    redirect(conn, to: ~p"/users/settings")
  end

  defp redirect_to(conn, nil) do
    render(conn, :home, layout: false)
  end
end
