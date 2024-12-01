defmodule ChallengeWeb.Presence do
  @moduledoc """
  Provides presence tracking to channels and processes.

  See the [`Phoenix.Presence`](https://hexdocs.pm/phoenix/Phoenix.Presence.html)
  docs for more details.
  """
  use Phoenix.Presence,
    otp_app: :challenge,
    pubsub_server: Challenge.PubSub

  def track_user_presence(session_id, view_module) do
    topic = "tracking:#{session_id}"

    track(self(), topic, session_id, %{
      view_module: view_module,
      joined_at: System.system_time(:second),
      engagement_time: 0
    })
  end
end
