defmodule JournalWeb.EntryController do
  use JournalWeb, :controller

  alias Journal.Entries
  alias Journal.Entries.Entry

  def index(conn, _params) do
    entries = Entries.list_entries()
              |> add_char_count()
    render(conn, "index.html", entries: entries)
  end

  defp add_char_count(list) do
    list
    |> Enum.map(&add_char_count_value/1)
  end

  defp add_char_count_value(entry) do
    char_count = String.length(entry.text)
    entry
    |> Map.put(:char_count, char_count)
  end

  def new(conn, %{"text" => title}) do
    changeset = Entries.change_entry(%Entry{title: title})
    render(conn, "new.html", changeset: changeset)
  end

  def new(conn, _params) do
    changeset = Entries.change_entry(%Entry{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"entry" => entry_params}) do
    case Entries.create_entry(entry_params) do
      {:ok, entry} ->
        conn
        |> put_flash(:info, "Entry created successfully.")
        |> redirect(to: Routes.entry_path(conn, :edit, entry))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    entry = Entries.get_entry!(id)
    render(conn, "show.html", entry: entry)
  end

  def edit(conn, %{"id" => id}) do
    entry = Entries.get_entry!(id)
    changeset = Entries.change_entry(entry)
    render(conn, "edit.html", entry: entry, changeset: changeset)
  end

  def update(conn, %{"id" => id, "entry" => entry_params}) do
    entry = Entries.get_entry!(id)

    case Entries.update_entry(entry, entry_params) do
      {:ok, entry} ->
        conn
        |> put_flash(:info, "Entry updated successfully.")
        |> render("edit.html", entry: entry, changeset: Entry.changeset(entry, entry_params))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", entry: entry, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    current_user = conn.assigns.current_user
    if current_user == nil do
      conn
      |> put_flash(:error, "Only users can do that.")
      |> show(%{"id" => id})
    else
      entry = Entries.get_entry!(id)
      {:ok, _entry} = Entries.delete_entry(entry)

      conn
      |> put_flash(:info, "Entry deleted successfully.")
      |> redirect(to: Routes.entry_path(conn, :index))
    end
  end
end
