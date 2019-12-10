defmodule Journal.VotesTest do
  use Journal.DataCase

  alias Journal.Votes

  describe "changes" do
    alias Journal.Votes.Change

    @valid_attrs %{text: "some text"}
    @update_attrs %{text: "some updated text"}
    @invalid_attrs %{text: nil}

    def change_fixture(attrs \\ %{}) do
      {:ok, change} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Votes.create_change()

      change
    end

    test "list_changes/0 returns all changes" do
      change = change_fixture()
      assert Votes.list_changes() == [change]
    end

    test "get_change!/1 returns the change with given id" do
      change = change_fixture()
      assert Votes.get_change!(change.id) == change
    end

    test "create_change/1 with valid data creates a change" do
      assert {:ok, %Change{} = change} = Votes.create_change(@valid_attrs)
      assert change.text == "some text"
    end

    test "create_change/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Votes.create_change(@invalid_attrs)
    end

    test "update_change/2 with valid data updates the change" do
      change = change_fixture()
      assert {:ok, %Change{} = change} = Votes.update_change(change, @update_attrs)
      assert change.text == "some updated text"
    end

    test "update_change/2 with invalid data returns error changeset" do
      change = change_fixture()
      assert {:error, %Ecto.Changeset{}} = Votes.update_change(change, @invalid_attrs)
      assert change == Votes.get_change!(change.id)
    end

    test "delete_change/1 deletes the change" do
      change = change_fixture()
      assert {:ok, %Change{}} = Votes.delete_change(change)
      assert_raise Ecto.NoResultsError, fn -> Votes.get_change!(change.id) end
    end

    test "change_change/1 returns a change changeset" do
      change = change_fixture()
      assert %Ecto.Changeset{} = Votes.change_change(change)
    end
  end
end
