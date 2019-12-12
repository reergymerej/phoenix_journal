defmodule JournalWeb.ChangeController do
  use JournalWeb, :controller

  alias Journal.Votes
  alias Journal.Votes.Change

  def index(conn, _params) do
    changes = Votes.list_changes()
    render(conn, "index.html",
      changes: changes,
      count: length changes
    )
  end

  def new(conn, _params) do
    changeset = Votes.change_change(%Change{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"change" => change_params}) do
    case Votes.create_change(change_params) do
      {:ok, change} ->
        conn
        |> put_flash(:info, "Change created successfully.")
        |> redirect(to: Routes.change_path(conn, :show, change))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    change = Votes.get_change!(id)
    render(conn, "show.html", change: change)
  end

  def edit(conn, %{"id" => id}) do
    change = Votes.get_change!(id)
    changeset = Votes.change_change(change)
    render(conn, "edit.html", change: change, changeset: changeset)
  end

  def update(conn, %{"id" => id, "change" => change_params}) do
    change = Votes.get_change!(id)

    case Votes.update_change(change, change_params) do
      {:ok, change} ->
        conn
        |> put_flash(:info, "Change updated successfully.")
        |> redirect(to: Routes.change_path(conn, :show, change))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", change: change, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    change = Votes.get_change!(id)
    {:ok, _change} = Votes.delete_change(change)

    conn
    |> put_flash(:info, "Change deleted successfully.")
    |> redirect(to: Routes.change_path(conn, :index))
  end

  def create_entry(conn, text) do
    IO.puts "hello"
    changeset = Votes.change_change(%Change{})
    render(conn, "new.html", changeset: changeset)
  end
end
