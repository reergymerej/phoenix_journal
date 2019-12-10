defmodule Journal.Repo.Migrations.AddTitleToEntry do
  use Ecto.Migration

  def change do
    alter table(:entries) do
      add :title, :string
    end
  end
end
