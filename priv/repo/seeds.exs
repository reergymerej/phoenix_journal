# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Journal.Repo.insert!(%Journal.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Journal.Repo
alias Journal.Entries.Entry

attrs = %{
  title: "Entry #1",
  text: "This is some text."
}

%Entry{}
  |> Entry.changeset(attrs)
  |> Repo.insert!()

attrs = %{
  title: "Entry #2",
  text: "This is some more text."
}

%Entry{}
  |> Entry.changeset(attrs)
  |> Repo.insert!()

%Entry{title: "Entry #3", text: "here is more"}
  |> Repo.insert!()

%Entry{text: "I have no title."}
  |> Repo.insert!()

alias Journal.Votes.Change

%Change{}
  |> Change.changeset(%{text: "Do the dang thing."})
  |> Repo.insert!()

%Change{}
  |> Change.changeset(%{text: "Have you considered making it shinier?"})
  |> Repo.insert!()

%Change{}
  |> Change.changeset(%{text: "Do the dang thing again."})
  |> Repo.insert!()
