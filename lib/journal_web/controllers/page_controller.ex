defmodule JournalWeb.PageController do
  use JournalWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
