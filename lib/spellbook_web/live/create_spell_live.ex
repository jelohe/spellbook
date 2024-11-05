defmodule SpellbookWeb.CreateSpellLive do
  use SpellbookWeb, :live_view
  alias SpellbookWeb.SpellFormComponent

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
