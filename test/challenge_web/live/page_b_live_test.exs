defmodule ChallengeWeb.PageBLive.IndexTest do
  use ChallengeWeb.ConnCase

  import Phoenix.LiveViewTest

  describe "Page B" do
    test "page a has the correct page title", %{conn: conn} do
      {:ok, live, _html} = live(conn, ~p"/page_b")
      assert page_title(live) =~ "Page B"
    end

    test "renders links to page A", %{conn: conn} do
      {:ok, live, _html} = live(conn, ~p"/page_b")

      {:ok, conn} =
        live
        |> element(~s{a[href="/page_a"]})
        |> render_click()
        |> follow_redirect(conn, ~p"/page_a")

      assert conn.resp_body =~ "Welcome to Page A"
    end

    test "renders links to page C", %{conn: conn} do
      {:ok, live, _html} = live(conn, ~p"/page_b")

      {:ok, conn} =
        live
        |> element(~s{a[href="/page_c"]})
        |> render_click()
        |> follow_redirect(conn, ~p"/page_c")

      assert conn.resp_body =~ "Welcome to Page C"
    end
  end
end
