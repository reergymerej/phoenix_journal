defmodule JournalWeb.Controllers.Helpers do
  use JournalWeb, :controller

  def restriction_warning(conn) do
    conn
    |> put_flash(:error, "Only users can do that.")
    |> redirect(to: Routes.session_path(conn, :new))
  end

  defp get_current_user(conn) do
    conn.assigns.current_user
  end

  def can_modify(conn) do
    get_current_user(conn) != nil
  end
end
