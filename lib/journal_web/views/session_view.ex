defmodule JournalWeb.SessionView do
  use JournalWeb, :view

  def has_user(conn) do
    conn.assigns[:current_user]
  end

  defp get_value(conn, user_value) do
    user = conn.params["user"]
    user[user_value]
  end

  defp has_value(data_source, name) do
    case get_value(data_source, name) do
      "" -> false
      nil -> false
      _ -> true
    end
  end

  def get_field_props(conn, field) do
    [
      placeholder: field,
      autofocus: !has_value(conn, field),
      value: get_value(conn, field)
    ]
  end
end
