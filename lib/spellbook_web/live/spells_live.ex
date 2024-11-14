defmodule SpellbookWeb.SpellsLive do
  use SpellbookWeb, :live_view
  alias Spellbook.{Spells, Spells.Spell}

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(_params, _uri, socket) do
    spells = Spells.list_spells()

    socket = assign(socket, spells: spells)
    {:noreply, socket}
  end

  def spell_component(assigns) do
    ~H"""
    <div>
      <%= @current_user.email %>/<%= @spell.name %>
    </div>  

    <div>
      <%= @spell.updated_at %>
    </div>  

    <div>
      <%= @spell.description %>
    </div>  

    <div>
      <%= @spell.markup_text %>
    </div>  
    """
  end

  def render(assigns) do
    ~H"""
    <div class="sp-gradient flex items-center justify-center">
      <h1 class="font-brand font-bold text-3xl text-white">
        All spells
      </h1>
    </div>

    <div class="w-1/2 mx-auto -mt-[48px] text-white">
      <%= for spell <- @spells do %>
        <.spell_component spell={spell} current_user={@current_user} />
        <hr />
      <% end %>
    </div>
    """
  end
end
