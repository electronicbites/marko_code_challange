defmodule ChallengeWeb.Live.LiveTracking do
  @moduledoc """
  Tracking Session for LiveViews#
  """
  alias Challenge.TrackingRepository
  alias ChallengeWeb.Presence

  use Phoenix.LiveView

  require Logger

  def track_session(%{tracking_session_id: tracking_session_id}, page) do
    Presence.track_user_presence(tracking_session_id, page)
  end

  def track_session(assigns, _page) do
    Logger.error("track_session: No tracking session found in assigns: #{inspect(assigns)}")
  end

  def save_pageview(%{tracking_session_id: tracking_session_id}) do
    topic = "tracking:#{tracking_session_id}"

    case Presence.get_by_key(topic, tracking_session_id) do
      %{metas: [%{engagement_time: time, view_module: view_module} | _]} ->
        TrackingRepository.save_pageview(tracking_session_id, view_module, time)

      _ ->
        :ok
    end
  end

  def save_pageview(assigns) do
    Logger.error("save_pageview: No tracking session found in assigns: #{inspect(assigns)}")
  end

  def keep_session_id(socket, %{"tracking_session_id" => tracking_session_id}) do
    assign(socket, tracking_session_id: tracking_session_id)
  end

  def keep_session_id(socket, _session), do: socket
end
