defmodule JournalWeb.SessionView do
  use JournalWeb, :view

  def has_user(conn) do
    conn.assigns[:current_user]
  end

  def has_value(data_source, name) do
    user = data_source.params["user"]
    IO.puts("checking it out")
    IO.inspect(user)
    IO.puts(name)
    # RESUME - get this
    IO.puts(user[name])
    false
  end
end
