defmodule Journal.Repo.Migrations.ExpandEntry do
  use Ecto.Migration

  def change do
    alter table(:entries) do
      modify :text, :text, [
        from: "character varying"
      ]
    end
  end
end
