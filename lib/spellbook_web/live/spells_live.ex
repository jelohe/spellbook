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
    <div class="flex justify-between">
      <img
        src="/images/user-image.svg"
        alt="Profile image"
        class="round-image-padding w-8 h-8"
      />
      <div class="flex flex-col">
        <div class="font-bold text-base text-spLavender-dark">
          <%= @spell.user_id %><span class="text-white">/</span><%= @spell.name %>
        </div>
        <div class="font-bold text-white text-lg">
          <%= @spell.updated_at %>
        </div>
        <p class="text-sm text-white">
          <%= @spell.description %>
        </p>
      </div>  
      <div class="flex flex-col">  
        <img src="/images/comment.svg" alt="Comment count"/>
        <span class="h-6 px-1">0</span>
      </div>  
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
