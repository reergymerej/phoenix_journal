defmodule JournalWeb.SessionView do
  use JournalWeb, :view

  def has_user(conn) do
    conn.assigns[:current_user]
  end

  def get_value(conn, user_value) do
    user = conn.params["user"]
    user[user_value]
  end

  def has_value(data_source, name) do
    case get_value(data_source, name) do
      "" -> false
      nil -> false
      _ -> true
    end
  end
end
