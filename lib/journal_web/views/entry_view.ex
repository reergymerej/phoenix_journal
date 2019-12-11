defmodule JournalWeb.EntryView do
  use JournalWeb, :view

  def get_title(%{title: title, text: text}) do
    case title do
      nil
        -> text
        |> trunc(80)
      _
        -> title
    end
  end

  defp trunc(string, max) do
    if (String.length(string) < max)do
      string
      |> String.slice(0, max)
    else
      (string
      |> String.slice(0, max - 3)) <> "..."
    end
  end
end
