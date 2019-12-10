defmodule Journal.Votes do
  @moduledoc """
  The Votes context.
  """

  import Ecto.Query, warn: false
  alias Journal.Repo

  alias Journal.Votes.Change

  @doc """
  Returns the list of changes.

  ## Examples

      iex> list_changes()
      [%Change{}, ...]

  """
  def list_changes do
    Repo.all(Change)
  end

  @doc """
  Gets a single change.

  Raises `Ecto.NoResultsError` if the Change does not exist.

  ## Examples

      iex> get_change!(123)
      %Change{}

      iex> get_change!(456)
      ** (Ecto.NoResultsError)

  """
  def get_change!(id), do: Repo.get!(Change, id)

  @doc """
  Creates a change.

  ## Examples

      iex> create_change(%{field: value})
      {:ok, %Change{}}

      iex> create_change(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_change(attrs \\ %{}) do
    %Change{}
    |> Change.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a change.

  ## Examples

      iex> update_change(change, %{field: new_value})
      {:ok, %Change{}}

      iex> update_change(change, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_change(%Change{} = change, attrs) do
    change
    |> Change.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Change.

  ## Examples

      iex> delete_change(change)
      {:ok, %Change{}}

      iex> delete_change(change)
      {:error, %Ecto.Changeset{}}

  """
  def delete_change(%Change{} = change) do
    Repo.delete(change)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking change changes.

  ## Examples

      iex> change_change(change)
      %Ecto.Changeset{source: %Change{}}

  """
  def change_change(%Change{} = change) do
    Change.changeset(change, %{})
  end
end
