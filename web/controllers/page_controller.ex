defmodule PhoenixUeberauthComeonin.PageController do
  use PhoenixUeberauthComeonin.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
