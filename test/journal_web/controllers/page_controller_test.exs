defmodule JournalWeb.PageControllerTest do
  use JournalWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Journal"
  end
end
