defmodule TrarecordWeb.PageController do
  use TrarecordWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
