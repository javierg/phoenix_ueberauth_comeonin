defmodule PhoenixUeberauthComeonin.PageController do
  use PhoenixUeberauthComeonin.Web, :controller

  plug Guardian.Plug.EnsureAuthenticated, handler: __MODULE__

  def index(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    render conn, "index.html", current_user: user
  end

  def unauthenticated(conn, _params) do
    conn
    |> put_status(401)
    |> put_flash(:error, "Authentication required")
    |> redirect(to: "/sessions/new")
  end
end
