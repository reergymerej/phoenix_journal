defmodule JournalWeb.LayoutView do
  use JournalWeb, :view

  def get_nav(conn) do
    links = [
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
      %{
        :label => "Questions",
        :href => Routes.question_path(conn, :index),
      },
      %{
        :label => "Login/Logout",
        :href => Routes.session_path(conn, :new),
      },
    ]

    add_optional(conn, links)
  end

  defp add_optional(conn, links) do
    if current_user = conn.assigns.current_user do
      links ++ [
        %{
          :label => "Your User",
          :href => Routes.user_path(conn, :show, current_user),
        }
      ]
    else
      links
    end
  end
end
