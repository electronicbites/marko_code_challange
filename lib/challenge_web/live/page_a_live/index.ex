defmodule ChallengeWeb.PageALive.Index do
  use ChallengeWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:page_title, "Page A")

    {:ok, socket}
  end
end
