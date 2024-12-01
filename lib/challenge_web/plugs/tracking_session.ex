defmodule ChallengeWeb.Plugs.TrackingSession do
  import Plug.Conn
  alias Challenge.TrackingRepository

  @cookie_name "tracking_id"
  # 1 year
  @cookie_max_age 60 * 60 * 24 * 365

  def init(opts), do: opts

  def call(conn, _opts) do
    case get_session_id(conn) do
      nil -> create_new_session(conn)
      id -> assign_existing_session(conn, id)
    end
  end

  defp get_session_id(conn) do
    conn.cookies[@cookie_name]
  end

  defp create_new_session(conn) do
    cookie_id = Ecto.UUID.generate()
    browser_agent = get_req_header(conn, "user-agent") |> List.first() || "unknown"

    {:ok, session} =
      TrackingRepository.create_session(%{
        cookie_id: cookie_id,
        browser_agent: browser_agent
      })

    conn
    |> put_resp_cookie(@cookie_name, cookie_id, max_age: @cookie_max_age)
    |> assign(:tracking_session_id, session.id)
    |> put_session(:tracking_session_id, session.id)
  end

  defp assign_existing_session(conn, cookie_id) do
    session = TrackingRepository.get_session_by_cookie_id(cookie_id)

    conn
    |> assign(:tracking_session_id, session.id)
    |> put_session(:tracking_session_id, session.id)
  end
end
