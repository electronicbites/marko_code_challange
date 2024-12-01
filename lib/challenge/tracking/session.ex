defmodule Challenge.Tracking.Session do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tracking_sessions" do
    field :browser_agent, :string
    field :cookie_id, :string

    has_many :page_views, Challenge.Tracking.PageView

    timestamps()
  end

  def changeset(session, attrs) do
    session
    |> cast(attrs, [:browser_agent, :cookie_id])
    |> validate_required([:browser_agent, :cookie_id])
  end
end
