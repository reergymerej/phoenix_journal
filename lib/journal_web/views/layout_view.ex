defmodule JournalWeb.LayoutView do
  use JournalWeb, :view

  def get_nav(conn) do
    [
      %{
        :label => "Home",
        :href => Routes.page_path(conn, :index)
      },
      %{
        :label => "Entries",
        :href => Routes.entry_path(conn, :index),
      },
      %{
        :label => "Changes",
        :href => Routes.change_path(conn, :index),
      },
    ]
  end
end
