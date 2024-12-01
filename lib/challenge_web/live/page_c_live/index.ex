defmodule ChallengeWeb.PageCLive.Index do
  use ChallengeWeb, :live_view
  alias ChallengeWeb.Live.UserPresence

  @impl true
  def mount(_params, session, socket) do
    socket = UserPresence.keep_session_id(socket, session)
    {:ok, assign(socket, current_tab: "tab_1", page_title: "Page C")}
  end

  @impl true
  def handle_params(_params, uri, socket) do
    cond do
      uri |> String.ends_with?("/page_c/tab_2") ->
        UserPresence.track_session(socket.assigns, __MODULE__ |> to_string())
        {:noreply, assign(socket, current_tab: "tab_2", page_title: "Page C, Tab 2")}

      uri |> String.ends_with?("/page_c/tab_1") ->
        UserPresence.track_session(socket.assigns, __MODULE__ |> to_string())
        {:noreply, assign(socket, current_tab: "tab_1", page_title: "Page C, Tab 1")}

      true ->
        # Handle /page_c by randomly selecting a tab
        random_tab = Enum.random(["tab_1", "tab_2"])
        {:noreply, push_patch(socket, to: "/page_c/#{random_tab}")}
    end
  end

  @impl true
  def terminate(_reason, socket) do
    UserPresence.save_pageview(socket.assigns)

    :ok
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.live_component module={ChallengeWeb.TabsComponent} id="tabs" current_tab={@current_tab} />
    """
  end
end
