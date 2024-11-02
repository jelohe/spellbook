defmodule Spellbook.Repo do
  use Ecto.Repo,
    otp_app: :spellbook,
    adapter: Ecto.Adapters.Postgres
end
