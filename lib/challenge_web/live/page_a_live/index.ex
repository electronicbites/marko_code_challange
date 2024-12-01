defmodule ChallengeWeb.PageALive.Index do
  use ChallengeWeb, :live_view
  alias ChallengeWeb.Live.LiveTracking

  @impl true
  def mount(_params, session, socket) do
    socket = LiveTracking.keep_session_id(socket, session)

    if connected?(socket) do
      LiveTracking.track_session(socket.assigns, __MODULE__ |> to_string())
    end

    {:ok, assign(socket, :page_title, "Page A")}
  end

  @impl true
  def terminate(_reason, socket) do
    LiveTracking.save_pageview(socket.assigns)
    :ok
  end
end
