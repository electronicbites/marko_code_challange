defmodule ChallengeWeb.PageALive.IndexTest do
  use ChallengeWeb.ConnCase

  import Phoenix.LiveViewTest

  describe "Page A" do
    test "page a has the correct page title", %{conn: conn} do
      {:ok, live, _html} = live(conn, ~p"/page_a")
      assert page_title(live) =~ "Page A"
    end

    test "renders links to page B", %{conn: conn} do
      {:ok, live, _html} = live(conn, ~p"/page_a")

      {:ok, conn} =
        live
        |> element(~s{a[href="/page_b"]})
        |> render_click()
        |> follow_redirect(conn, ~p"/page_b")

      assert conn.resp_body =~ "Welcome to Page B"
    end

    test "renders links to page C", %{conn: conn} do
      {:ok, live, _html} = live(conn, ~p"/page_a")

      {:ok, conn} =
        live
        |> element(~s{a[href="/page_c"]})
        |> render_click()
        |> follow_redirect(conn, ~p"/page_c")

      assert conn.resp_body =~ "Welcome to Page C"
    end
  end
end
