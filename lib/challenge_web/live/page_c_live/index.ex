defmodule ChallengeWeb.PageCLive.Index do
  use ChallengeWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
