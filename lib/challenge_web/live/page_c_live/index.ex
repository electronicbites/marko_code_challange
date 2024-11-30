defmodule ChallengeWeb.PageCLive.Index do
  use ChallengeWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:page_title, "FOOO BAR")

    {:ok, socket}
  end
end
