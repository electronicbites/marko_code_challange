defmodule ChallengeWeb.PageCLive.IndexTest do
  use ChallengeWeb.ConnCase

  import Phoenix.LiveViewTest

  describe "Page C" do
    test "renders links to page A", %{conn: conn} do
      {:ok, live, _html} = live(conn, ~p"/page_c")

      {:ok, conn} =
        live
        |> element(~s{a[href="/page_a"]})
        |> render_click()
        |> follow_redirect(conn, ~p"/page_a")

      assert conn.resp_body =~ "Welcome to Page A"
    end

    test "renders links to page B", %{conn: conn} do
      {:ok, live, _html} = live(conn, ~p"/page_c")

      {:ok, conn} =
        live
        |> element(~s{a[href="/page_b"]})
        |> render_click()
        |> follow_redirect(conn, ~p"/page_b")

      assert conn.resp_body =~ "Welcome to Page B"
    end
  end
end
