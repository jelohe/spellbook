defmodule SpellbookWeb.SpellsLive do
  use SpellbookWeb, :live_view
  alias Spellbook.{Spells, Spells.Spell}
  alias SpellbookWeb.Utilities.DateFormat

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
    <div class="justify-center px-28 w-full mb-20">
      <div class="flex justify-between">
        <div class="flex items-center">
          <img
            src="/images/user-image.svg"
            alt="Profile image"
            class="round-image-padding w-8 h-8"
          />
          <div class="flex flex-col ml-4">
            <div class="font-bold text-base text-spLavender-dark">
              <%= @spell.user_id %><span class="text-white">/</span><%= @spell.name %>
            </div>
            <div class="font-bold text-white text-lg">
              <%= DateFormat.get_relative_time(@spell.updated_at) %>
            </div>
            <p class="text-sm text-white">
              <%= @spell.description %>
            </p>
          </div>  
        </div>  
        <div class="flex items-center">  
          <img src="/images/comment.svg" alt="Comment count"/>
          <span class="text-white h-6 px-1">0</span>
          <img src="/images/BookmarkOutline.svg" alt="Bookmark count"/>
          <span class="text-white h-6 px-1">0</span>
        </div>  
      </div>  

      <div id="spell-wrapper" class="flex w-full mt-8">
        <textarea
          id="line-numbers"
          class="syntax-numbers rounded-bl-md rounded-tl-md"
          readonly
        ></textarea>
        <div id="highlight" class="syntax-area w-full rounded-r-md" phx-hook="Highlight" data-name={@spell.name}>
          <pre>
            <code class="language-elixir">
              <%= get_preview_text(@spell) %>
            </code>
          </pre>
        </div>
      </div>

    </div>  
    """
  end

  defp get_preview_text(spell) when not is_nil(spell.markup_text) do
    lines = spell.markup_text |> String.split("\n")

    if length(lines) > 10 do
      Enum.take(lines, 9) ++ ["..."] |> Enum.join("\n")
    else
      spell.markup_text
    end
  end

  defp get_preview_text(spell), do: ""

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
      <% end %>
    </div>
    """
  end
end
