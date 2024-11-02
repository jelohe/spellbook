defmodule Spellbook.SpellsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Spellbook.Spells` context.
  """

  @doc """
  Generate a spell.
  """
  def spell_fixture(attrs \\ %{}) do
    {:ok, spell} =
      attrs
      |> Enum.into(%{
        description: "some description",
        markup_text: "some markup_text",
        name: "some name"
      })
      |> Spellbook.Spells.create_spell()

    spell
  end

  @doc """
  Generate a saved_spell.
  """
  def saved_spell_fixture(attrs \\ %{}) do
    {:ok, saved_spell} =
      attrs
      |> Enum.into(%{

      })
      |> Spellbook.Spells.create_saved_spell()

    saved_spell
  end
end
