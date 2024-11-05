defmodule SpellbookWeb.SpellLive do
  use SpellbookWeb, :live_view
  alias Spellbook.Spells

  def mount(%{"id" => id}, _session, socket) do
    spell = Spells.get_spell!(id)

    {:ok, relative_time} = Timex.format(spell.updated_at, "{relative}", :relative)
    spell = Map.put(spell, :relative, relative_time)
    {:ok, assign(socket, spell: spell)}
  end

  def handle_event("delete", %{"id" => id}, socket) do
    case Spells.delete_spell(socket.assigns.current_user, id) do
      {:ok, _spell} -> 
        socket = put_flash(socket, :info, "Spell deleted")
        {:noreply, push_navigate(socket, to: ~p"/create")}
      {:error, message} -> 
        socket = put_flash(socket, :error, message)
        {:noreply, socket}
    end
  end
end
