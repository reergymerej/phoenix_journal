defmodule JournalWeb.SessionView do
  use JournalWeb, :view

  def has_user(conn) do
    conn.assigns[:current_user]
  end
end
