defmodule Spellbook.Spells.Spell do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "spells" do
    field :name, :string
    field :description, :string
    field :markup_text, :string
    belongs_to :user, Spellbook.Accounts.User
    has_many :comments, Spellbook.Comments.Comment

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(spell, attrs) do
    spell
    |> cast(attrs, [:name, :description, :markup_text, :user_id])
    |> validate_required([:name, :user_id])
  end
end
