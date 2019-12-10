defmodule Journal.Repo.Migrations.CreateChanges do
  use Ecto.Migration

  def change do
    create table(:changes) do
      add :text, :text

      timestamps()
    end

  end
end
