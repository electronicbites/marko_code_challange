defmodule ChallengeWeb.PageALive.IndexTest do
  use ChallengeWeb.ConnCase

  import Phoenix.LiveViewTest

  describe "Page A" do
    test "renders links to page B", %{conn: conn} do
      {:ok, live, _html} = live(conn, ~p"/page_a")
      {:ok, conn} =
        live
        |> element(~s{a[href="/page_b"]})
        |> render_click()
        |> follow_redirect(conn, ~p"/page_b")

      assert conn.resp_body =~ "Page B"
    end
  end
end
