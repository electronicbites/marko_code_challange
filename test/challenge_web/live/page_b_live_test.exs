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

    test "renders links to page C Tab 2", %{conn: conn} do
      {:ok, live, _html} = live(conn, ~p"/page_b")

      {:ok, conn} =
        live
        |> element(~s{a[href="/page_c/tab_2"]})
        |> render_click()
        |> follow_redirect(conn, ~p"/page_c/tab_2")

      assert conn.resp_body =~ "Welcome to Page C, Tab 2"
    end
  end
end
