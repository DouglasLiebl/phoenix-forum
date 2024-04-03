defmodule ForumWeb.Router do
  use ForumWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ForumWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ForumWeb do
    pipe_through :browser
    get "/", PageController, :home
  end

  scope "/api", ForumWeb do
    pipe_through :api
    resources "/posts", PostController, except: [:new, :edit]

    resources "/users", UserController, except: [:new, :edit]
  end
end
