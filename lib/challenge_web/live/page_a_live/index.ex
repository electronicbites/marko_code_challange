defmodule ChallengeWeb.PageALive.Index do
  use ChallengeWeb, :live_view

    @impl true
    def mount(_params, _session, socket) do
      {:ok, socket}
    end
end
