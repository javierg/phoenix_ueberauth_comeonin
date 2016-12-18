defmodule PhoenixUeberauthComeonin.SessionsController do
  use PhoenixUeberauthComeonin.Web, :controller

  alias Ueberauth.Strategy.Helpers

  plug Ueberauth

  def new(conn, _params) do
    render conn, "new.html", callback_url: Helpers.callback_url(conn), current_user: nil
  end

  def destroy(conn, _params) do
    conn
    |> Guardian.Plug.sign_out
    |> put_flash(:info, "Logged out")
    |> redirect(to: "/sessions/new")
  end

  def identity_callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
    conn
    |> authenticated(User.authenticate auth)
  end

  defp authenticated(conn, {:ok, user}) do
    conn
    |> put_flash(:info, "Successfully authenticated.")
    |> Guardian.Plug.sign_in(user)
    |> redirect(to: "/")
  end

  defp authenticated(conn, {:error, error}) do
    conn
    |> put_flash(:error, error)
    |> redirect(to: "/sessions/new")
  end
end
