defmodule SpellbookWeb.CreateSpellLive do
  use SpellbookWeb, :live_view
  alias SpellbookWeb.SpellFormComponent
  alias Spellbook.{Spells, Spells.Spell}

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="sp-gradient flex items-center justify-center">
      <h1 class="font-brand font-bold text-3xl text-white">
        Store and share your magic.
      </h1>
      </div>
      <.live_component
        module={SpellFormComponent}
        id={:new}
        form={to_form(Spells.change_spell(%Spell{}))}
        current_user={@current_user}
       />
    """
  end
end
