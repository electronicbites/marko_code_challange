defmodule ChallengeWeb.TabsComponent do
  use ChallengeWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class="bg-white shadow sm:rounded-lg">
      <div class="border-b border-gray-200">
        <nav class="-mb-px flex space-x-8 px-4" aria-label="Tabs">
          <.link
            href={~p"/page_c/tab_1"}
            class={[
              "whitespace-nowrap py-4 px-1 border-b-2 font-medium text-sm",
              (@current_tab == "tab_1" && "border-indigo-500 text-indigo-600") ||
                "border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300"
            ]}
          >
            Tab 1
          </.link>
          <.link
            href={~p"/page_c/tab_2"}
            class={[
              "whitespace-nowrap py-4 px-1 border-b-2 font-medium text-sm",
              (@current_tab == "tab_2" && "border-indigo-500 text-indigo-600") ||
                "border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300"
            ]}
          >
            Tab 2
          </.link>
        </nav>
      </div>
      <div class="px-4 py-5 sm:p-6">
        <%= if @current_tab == "tab_1" do %>
          <h1 class="text-2xl font-semibold text-gray-900 mb-6">Welcome to Page C, Tab 1</h1>
          <.link href={~p"/page_b"} class="text-indigo-600 hover:text-indigo-900">Go to Page B</.link>
        <% else %>
          <h1 class="text-2xl font-semibold text-gray-900 mb-6">Welcome to Page C, Tab 2</h1>
          <.link href={~p"/page_a"} class="text-indigo-600 hover:text-indigo-900">Go to Page A</.link>
        <% end %>
      </div>
    </div>
    """
  end
end
