defmodule Journal.Entries.Entry do
  use Ecto.Schema
  import Ecto.Changeset

  schema "entries" do
    field :text, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(entry, attrs) do
    entry
    |> cast(attrs, [
      :text,
      :title,
    ])
    |> validate_required([:title, :text])
  end
end
