defmodule JournalWeb.ChangeControllerTest do
  use JournalWeb.ConnCase

  alias Journal.Votes

  @create_attrs %{text: "some text"}
  @update_attrs %{text: "some updated text"}
  @invalid_attrs %{text: nil}

  def fixture(:change) do
    {:ok, change} = Votes.create_change(@create_attrs)
    change
  end

  describe "index" do
    test "lists all changes", %{conn: conn} do
      conn = get(conn, Routes.change_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Changes"
    end
  end

  describe "new change" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.change_path(conn, :new))
      assert html_response(conn, 200) =~ "New Change"
    end
  end

  describe "create change" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.change_path(conn, :create), change: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.change_path(conn, :show, id)

      conn = get(conn, Routes.change_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Change"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.change_path(conn, :create), change: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Change"
    end
  end

  describe "edit change" do
    setup [:create_change]

    test "renders form for editing chosen change", %{conn: conn, change: change} do
      conn = get(conn, Routes.change_path(conn, :edit, change))
      assert html_response(conn, 200) =~ "Edit Change"
    end
  end

  describe "update change" do
    setup [:create_change]

    test "redirects when data is valid", %{conn: conn, change: change} do
      conn = put(conn, Routes.change_path(conn, :update, change), change: @update_attrs)
      assert redirected_to(conn) == Routes.change_path(conn, :show, change)

      conn = get(conn, Routes.change_path(conn, :show, change))
      assert html_response(conn, 200) =~ "some updated text"
    end

    test "renders errors when data is invalid", %{conn: conn, change: change} do
      conn = put(conn, Routes.change_path(conn, :update, change), change: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Change"
    end
  end

  describe "delete change" do
    setup [:create_change]

    test "deletes chosen change", %{conn: conn, change: change} do
      conn = delete(conn, Routes.change_path(conn, :delete, change))
      assert redirected_to(conn) == Routes.change_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.change_path(conn, :show, change))
      end
    end
  end

  defp create_change(_) do
    change = fixture(:change)
    {:ok, change: change}
  end
end
