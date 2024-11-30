defmodule ChallengeWeb.PageCLive.IndexTest do
  use ChallengeWeb.ConnCase

  import Phoenix.LiveViewTest

  describe "Page C" do
    test "redirects random", %{conn: conn} do
      {:error, {:live_redirect, %{to: redirect, flash: %{}}}} = live(conn, ~p"/page_c")
      # randomly selects a tab and redirects to that tab
      assert redirect =~ ~r{^/page_c/(tab_1|tab_2)$}
    end

    test "renders links to page B on tab 1", %{conn: conn} do
      {:ok, live, _html} = live(conn, ~p"/page_c/tab_1")

      {:ok, conn} =
        live
        |> element(~s{a[href="/page_b"]})
        |> render_click()
        |> follow_redirect(conn, ~p"/page_b")

      assert conn.resp_body =~ "Welcome to Page B"
    end

    test "renders links to page A on tab 2", %{conn: conn} do
      {:ok, live, _html} = live(conn, ~p"/page_c/tab_2")

      {:ok, conn} =
        live
        |> element(~s{a[href="/page_a"]})
        |> render_click()
        |> follow_redirect(conn, ~p"/page_a")

      assert conn.resp_body =~ "Welcome to Page A"
    end
  end
end
