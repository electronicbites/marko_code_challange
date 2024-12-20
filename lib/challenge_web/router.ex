defmodule ChallengeWeb.Router do
  use ChallengeWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, html: {ChallengeWeb.Layouts, :root})
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug ChallengeWeb.Plugs.TrackingSession
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", ChallengeWeb do
    pipe_through(:browser)

    get("/", PageController, :home)

    live_session :track_sessions do
      live("/page_a", PageALive.Index, :index)

      live("/page_b", PageBLive.Index, :index)
      live("/page_c", PageCLive.Index, :index)
      live("/page_c/tab_1", PageCLive.Index, :tab_1)
      live("/page_c/tab_2", PageCLive.Index, :tab_2)
    end
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:challenge, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through(:browser)

      live_dashboard("/dashboard", metrics: ChallengeWeb.Telemetry)
      forward("/mailbox", Plug.Swoosh.MailboxPreview)
    end
  end
end
