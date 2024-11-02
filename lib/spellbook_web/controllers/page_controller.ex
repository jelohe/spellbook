defmodule SpellbookWeb.PageController do
  use SpellbookWeb, :controller

  def home(conn, _params) do
    redirect(conn, to: "/create")
  end
end
