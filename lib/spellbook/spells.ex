defmodule Spellbook.Spells do
  @moduledoc """
  The Spells context.
  """

  import Ecto.Query, warn: false
  alias Spellbook.Repo

  alias Spellbook.Spells.Spell

  @doc """
  Returns the list of spells.

  ## Examples

      iex> list_spells()
      [%Spell{}, ...]

  """
  def list_spells do
    Repo.all(Spell)
  end

  @doc """
  Gets a single spell.

  Raises `Ecto.NoResultsError` if the Spell does not exist.

  ## Examples

      iex> get_spell!(123)
      %Spell{}

      iex> get_spell!(456)
      ** (Ecto.NoResultsError)

  """
  def get_spell!(id), do: Repo.get!(Spell, id)

  @doc """
  Creates a spell.

  ## Examples

      iex> create_spell(%{field: value})
      {:ok, %Spell{}}

      iex> create_spell(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_spell(user, attrs \\ %{}) do
    user
    |> Ecto.build_assoc(:spells)
    |> Spell.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a spell.

  ## Examples

      iex> update_spell(spell, %{field: new_value})
      {:ok, %Spell{}}

      iex> update_spell(spell, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_spell(%Spell{} = spell, attrs) do
    spell
    |> Spell.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a spell.

  ## Examples

      iex> delete_spell(spell)
      {:ok, %Spell{}}

      iex> delete_spell(spell)
      {:error, %Ecto.Changeset{}}

  """
  def delete_spell(%Spell{} = spell) do
    Repo.delete(spell)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking spell changes.

  ## Examples

      iex> change_spell(spell)
      %Ecto.Changeset{data: %Spell{}}

  """
  def change_spell(%Spell{} = spell, attrs \\ %{}) do
    Spell.changeset(spell, attrs)
  end

  alias Spellbook.Spells.SavedSpell

  @doc """
  Returns the list of saved_spells.

  ## Examples

      iex> list_saved_spells()
      [%SavedSpell{}, ...]

  """
  def list_saved_spells do
    Repo.all(SavedSpell)
  end

  @doc """
  Gets a single saved_spell.

  Raises `Ecto.NoResultsError` if the Saved spell does not exist.

  ## Examples

      iex> get_saved_spell!(123)
      %SavedSpell{}

      iex> get_saved_spell!(456)
      ** (Ecto.NoResultsError)

  """
  def get_saved_spell!(id), do: Repo.get!(SavedSpell, id)

  @doc """
  Creates a saved_spell.

  ## Examples

      iex> create_saved_spell(%{field: value})
      {:ok, %SavedSpell{}}

      iex> create_saved_spell(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_saved_spell(user, attrs \\ %{}) do
    user
    |> Ecto.build_assoc(:saved_spells)
    |> SavedSpell.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a saved_spell.

  ## Examples

      iex> update_saved_spell(saved_spell, %{field: new_value})
      {:ok, %SavedSpell{}}

      iex> update_saved_spell(saved_spell, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_saved_spell(%SavedSpell{} = saved_spell, attrs) do
    saved_spell
    |> SavedSpell.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a saved_spell.

  ## Examples

      iex> delete_saved_spell(saved_spell)
      {:ok, %SavedSpell{}}

      iex> delete_saved_spell(saved_spell)
      {:error, %Ecto.Changeset{}}

  """
  def delete_saved_spell(%SavedSpell{} = saved_spell) do
    Repo.delete(saved_spell)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking saved_spell changes.

  ## Examples

      iex> change_saved_spell(saved_spell)
      %Ecto.Changeset{data: %SavedSpell{}}

  """
  def change_saved_spell(%SavedSpell{} = saved_spell, attrs \\ %{}) do
    SavedSpell.changeset(saved_spell, attrs)
  end
end
