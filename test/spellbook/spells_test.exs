defmodule Spellbook.SpellsTest do
  use Spellbook.DataCase

  alias Spellbook.Spells

  describe "spells" do
    alias Spellbook.Spells.Spell

    import Spellbook.SpellsFixtures

    @invalid_attrs %{name: nil, description: nil, markup_text: nil}

    test "list_spells/0 returns all spells" do
      spell = spell_fixture()
      assert Spells.list_spells() == [spell]
    end

    test "get_spell!/1 returns the spell with given id" do
      spell = spell_fixture()
      assert Spells.get_spell!(spell.id) == spell
    end

    test "create_spell/1 with valid data creates a spell" do
      valid_attrs = %{name: "some name", description: "some description", markup_text: "some markup_text"}

      assert {:ok, %Spell{} = spell} = Spells.create_spell(valid_attrs)
      assert spell.name == "some name"
      assert spell.description == "some description"
      assert spell.markup_text == "some markup_text"
    end

    test "create_spell/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Spells.create_spell(@invalid_attrs)
    end

    test "update_spell/2 with valid data updates the spell" do
      spell = spell_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description", markup_text: "some updated markup_text"}

      assert {:ok, %Spell{} = spell} = Spells.update_spell(spell, update_attrs)
      assert spell.name == "some updated name"
      assert spell.description == "some updated description"
      assert spell.markup_text == "some updated markup_text"
    end

    test "update_spell/2 with invalid data returns error changeset" do
      spell = spell_fixture()
      assert {:error, %Ecto.Changeset{}} = Spells.update_spell(spell, @invalid_attrs)
      assert spell == Spells.get_spell!(spell.id)
    end

    test "delete_spell/1 deletes the spell" do
      spell = spell_fixture()
      assert {:ok, %Spell{}} = Spells.delete_spell(spell)
      assert_raise Ecto.NoResultsError, fn -> Spells.get_spell!(spell.id) end
    end

    test "change_spell/1 returns a spell changeset" do
      spell = spell_fixture()
      assert %Ecto.Changeset{} = Spells.change_spell(spell)
    end
  end

  describe "saved_spells" do
    alias Spellbook.Spells.SavedSpell

    import Spellbook.SpellsFixtures

    @invalid_attrs %{}

    test "list_saved_spells/0 returns all saved_spells" do
      saved_spell = saved_spell_fixture()
      assert Spells.list_saved_spells() == [saved_spell]
    end

    test "get_saved_spell!/1 returns the saved_spell with given id" do
      saved_spell = saved_spell_fixture()
      assert Spells.get_saved_spell!(saved_spell.id) == saved_spell
    end

    test "create_saved_spell/1 with valid data creates a saved_spell" do
      valid_attrs = %{}

      assert {:ok, %SavedSpell{} = saved_spell} = Spells.create_saved_spell(valid_attrs)
    end

    test "create_saved_spell/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Spells.create_saved_spell(@invalid_attrs)
    end

    test "update_saved_spell/2 with valid data updates the saved_spell" do
      saved_spell = saved_spell_fixture()
      update_attrs = %{}

      assert {:ok, %SavedSpell{} = saved_spell} = Spells.update_saved_spell(saved_spell, update_attrs)
    end

    test "update_saved_spell/2 with invalid data returns error changeset" do
      saved_spell = saved_spell_fixture()
      assert {:error, %Ecto.Changeset{}} = Spells.update_saved_spell(saved_spell, @invalid_attrs)
      assert saved_spell == Spells.get_saved_spell!(saved_spell.id)
    end

    test "delete_saved_spell/1 deletes the saved_spell" do
      saved_spell = saved_spell_fixture()
      assert {:ok, %SavedSpell{}} = Spells.delete_saved_spell(saved_spell)
      assert_raise Ecto.NoResultsError, fn -> Spells.get_saved_spell!(saved_spell.id) end
    end

    test "change_saved_spell/1 returns a saved_spell changeset" do
      saved_spell = saved_spell_fixture()
      assert %Ecto.Changeset{} = Spells.change_saved_spell(saved_spell)
    end
  end
end
