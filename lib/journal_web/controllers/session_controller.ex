defmodule JournalWeb.SessionController do
  use JournalWeb, :controller
  alias Journal.Accounts

  def new(conn, _) do
    render(conn, "new.html")
  end

  def start_user_session(conn, %Journal.Accounts.User{id: id}) do
    conn
    |> put_session(:user_id, id)
    |> configure_session(renew: true)
  end

  def create(conn, %{"user" => %{"email" => email, "password" => password}}) do
    case Accounts.authenticate_by_email_password(email, password) do
      {:ok, user} ->
        conn
        |> start_user_session(user)
        |> put_flash(:info, "welcome")
        |> redirect(to: "/")
      {:error, :unauthorized} ->
        conn
        |> put_flash(:error, "bad combo")
        |> new(%{})
    end
  end

  def delete(conn, _) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end
end
