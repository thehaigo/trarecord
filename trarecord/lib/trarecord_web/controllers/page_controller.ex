defmodule TrarecordWeb.PageController do
  use TrarecordWeb, :controller

  alias Trarecord.Users.User

  def index(conn, _params) do
    redirect_to(conn, conn.assigns.current_user)
  end

  def redirect_to(conn, %User{}) do
    redirect(conn, to: Routes.live_path(TrarecordWeb.Endpoint, TrarecordWeb.HomeLive))
  end

  def redirect_to(conn, nil) do
    redirect(conn, to: Routes.user_registration_path(TrarecordWeb.Endpoint, :new))
  end
end
