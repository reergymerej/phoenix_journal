defmodule Journal.Repo.Migrations.CreateEntries do
  use Ecto.Migration

  def change do
    create table(:entries) do
      add :text, :string

      timestamps()
    end

  end
end
