defmodule SpellbookWeb.CreateSpellLive do
  use SpellbookWeb, :live_view
  alias Spellbook.{Spells, Spells.Spell}

  def mount(_params, _session, socket) do
    empty_spell = Spells.change_spell(%Spell{})
    new_socket = assign(socket, form: to_form(empty_spell))

    {:ok, new_socket}
  end

  def handle_event("validate", %{"spell" => params}, socket) do
    changeset = %Spell{}
      |> Spells.change_spell(params)
      |> Map.put(:action, :validate)
    {:noreply, assign(socket, :form, to_form(changeset))}
  end

  def handle_event("create", %{"spell" => params}, socket) do
    case Spells.create_spell(socket.assigns.current_user, params) do
      {:ok, spell} ->
        socket = push_event(socket, "spell-created", %{})
        changeset = Spells.change_spell(%Spell{})
        socket = assign(socket, :form, to_form(changeset))
        {:noreply, push_navigate(socket, to: ~p"/spell?#{[id: spell]}")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :form, to_form(changeset))}
    end
  end
end
