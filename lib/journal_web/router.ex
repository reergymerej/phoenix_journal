defmodule JournalWeb.Router do
  use JournalWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", JournalWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/entries", EntryController
    resources "/changes", ChangeController do
      post "/top", ChangeController, :top, as: "top"
    end
    resources "/users", UserController, except: [:index]
    resources "/sessions", SessionController, only: [:new, :create, :delete], singleton: true
    resources "/questions", QuestionController
  end

  # defp authenticate_user(conn, _) do
  #   case get_session(conn, :user_id) do
  #     nil ->
  #       conn
  #       |> Phoenix.Controller.put_flash(:error, "login first")
  #       |> Phoenix.Controller.redirect(to: "/")
  #       |> halt()
  #     user_id ->
  #       assign(conn, :current_user, Journal.Accounts.get_user!(user_id))
  #   end
  # end

  defp fetch_user(conn, _) do
    case get_session(conn, :user_id) do
      nil ->
        assign(conn, :current_user, nil)
      user_id ->
        assign(conn, :current_user, Journal.Accounts.get_user!(user_id))
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", JournalWeb do
  #   pipe_through :api
  # end
end
