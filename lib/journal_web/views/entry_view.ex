defmodule JournalWeb.EntryView do
  use JournalWeb, :view

  def get_title(%{title: title, text: text}) do
    case title do
      nil
        -> text
      _
        -> title
    end
  end
end
