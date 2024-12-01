defmodule ChallengeWeb.PageBLive.Index do
  use ChallengeWeb, :live_view
  alias ChallengeWeb.Live.UserPresence

  @impl true
  def mount(_params, session, socket) do
    socket = UserPresence.keep_session_id(socket, session)

    if connected?(socket) do
      UserPresence.track_session(socket.assigns, __MODULE__ |> to_string())
    end

    socket =
      socket
      |> assign(:page_title, "Page B")

    {:ok, socket}
  end

  @impl true
  def terminate(_reason, socket) do
    UserPresence.save_pageview(socket.assigns)

    :ok
  end
end
