defmodule ChallengeWeb.PageBLive.IndexTest do
  use ChallengeWeb.ConnCase

  import Phoenix.LiveViewTest

  describe "Page B" do
    test "renders links to page A", %{conn: conn} do
      {:ok, live, _html} = live(conn, ~p"/page_b")
      {:ok, conn} =
        live
        |> element(~s{a[href="/page_a"]})
        |> render_click()
        |> follow_redirect(conn, ~p"/page_a")

      assert conn.resp_body =~ "Page A"
    end
  end
end
