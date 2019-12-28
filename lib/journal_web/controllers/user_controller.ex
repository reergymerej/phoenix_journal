defmodule JournalWeb.UserController do
  use JournalWeb, :controller

  alias Journal.Accounts
  alias Journal.Accounts.User
  alias JournalWeb.Controllers.Helpers

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> JournalWeb.SessionController.start_user_session(user)
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  defp kick_out(conn) do
    Helpers.restriction_warning(conn)
  end

  defp current_user_id_matches(nil, _id) do
    false
  end

  defp current_user_id_matches(current_user, id) do
    current_user_id = current_user.id
    case Integer.parse(id) do
      {^current_user_id, _} ->
        true
      _ ->
        false
    end
  end

  def show(conn, %{"id" => id}) do
    ok = current_user_id_matches(conn.assigns.current_user, id)
    if ok do
      user = Accounts.get_user!(id)
      render(conn, "show.html", user: user)
    else
      kick_out(conn)
    end
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
  end
end
