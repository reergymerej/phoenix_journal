defmodule Journal.Votes.Change do
  use Ecto.Schema
  import Ecto.Changeset

  schema "changes" do
    field :text, :string

    timestamps()
  end

  @doc false
  def changeset(change, attrs) do
    change
    |> cast(attrs, [:text])
    |> validate_required([:text])
  end
end
