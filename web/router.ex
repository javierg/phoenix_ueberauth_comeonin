defmodule PhoenixUeberauthComeonin.Router do
  use PhoenixUeberauthComeonin.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :authorization do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhoenixUeberauthComeonin do
    pipe_through [:browser, :authorization]

    get "/", PageController, :index
  end

  scope "/sessions", PhoenixUeberauthComeonin do
    pipe_through [:browser]

    get "/new", SessionsController, :new
    post "/identity/callback", SessionsController, :identity_callback
    delete "/", SessionsController, :destroy
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhoenixUeberauthComeonin do
  #   pipe_through :api
  # end
end
