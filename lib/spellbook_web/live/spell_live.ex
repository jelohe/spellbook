defmodule SpellbookWeb.SpellLive do
  use SpellbookWeb, :live_view

  alias Spellbook.Spells

  def mount(%{"id" => id}, _session, socket) do
    spell = Spells.get_spell!(id)
    {:ok, assign(socket, spell: spell)}
  end
end
