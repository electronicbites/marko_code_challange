defmodule Challenge.TrackingRepository do
  @moduledoc """
    Repository for tracking data
  """
  alias Challenge.Repo
  alias Challenge.Tracking.{Session, PageView}

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
end
