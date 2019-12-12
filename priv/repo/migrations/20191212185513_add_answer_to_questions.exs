defmodule Journal.Repo.Migrations.AddAnswerToQuestions do
  use Ecto.Migration

  def change do
    alter table("questions") do
      add :answer, :text
    end
  end
end
