defmodule Spellbook.Spells.SavedSpell do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "saved_spells" do
    
    belongs_to :user, Spellbook.Accounts.User
    belongs_to :spell, Spellbook.Spells.Spell

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(saved_spell, attrs) do
    saved_spell
    |> cast(attrs, [:user_id, :spell_id])
    |> validate_required([:user_id, :spell_id])
  end
end
