defmodule Spellbook.Repo.Migrations.CreateSavedSpells do
  use Ecto.Migration

  def change do
    create table(:saved_spells, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, on_delete: :delete_all, type: :binary_id)
      add :spell_id, references(:spells, on_delete: :delete_all, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:saved_spells, [:user_id])
    create index(:saved_spells, [:spell_id])
  end
end
