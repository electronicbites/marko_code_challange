defmodule Challenge.Tracking do
  alias Challenge.Repo
  alias Challenge.Tracking.{Session, PageView}
  alias ChallengeWeb.Presence

  def track_user_presence(session_id, view_module) do
    topic = "tracking:#{session_id}"

    Presence.track(self(), topic, session_id, %{
      view_module: view_module,
      joined_at: System.system_time(:second),
      engagement_time: 0
    })
  end

  def create_session(attrs) do
    %Session{}
    |> Session.changeset(attrs)
    |> Repo.insert()
  end

  def get_session_by_cookie_id(cookie_id) do
    Repo.get_by(Session, cookie_id: cookie_id)
  end

  def save_pageview(session_id, view_module, engagement_time) do
    %PageView{}
    |> PageView.changeset(%{
      session_id: session_id,
      view_module: view_module,
      engagement_time: engagement_time
    })
    |> Repo.insert()
  end

  def list_active_sessions do
    Presence.list("tracking:global")
  end
end
