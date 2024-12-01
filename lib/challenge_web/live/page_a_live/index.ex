defmodule ChallengeWeb.PageALive.Index do
  use ChallengeWeb, :live_view
  alias ChallengeWeb.Live.UserPresence

  @impl true
  def mount(_params, session, socket) do
    socket = UserPresence.keep_session_id(socket, session)

    if connected?(socket) do
      UserPresence.track_session(socket.assigns, __MODULE__ |> to_string())
    end

    {:ok, assign(socket, :page_title, "Page A")}
  end

  @impl true
  def terminate(_reason, socket) do
    UserPresence.save_pageview(socket.assigns)
    :ok
  end

  @impl true
  def handle_info(%Phoenix.Socket.Broadcast{event: "presence_diff"}, socket) do
    {:noreply, socket}
  end
end
