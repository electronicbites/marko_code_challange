defmodule Challenge.Tracking.PageView do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tracking_page_views" do
    field :view_module, :string
    field :additional_info, :map
    field :engagement_time, :integer, default: 0

    belongs_to :session, Challenge.Tracking.Session

    timestamps()
  end

  def changeset(pageview, attrs) do
    pageview
    |> cast(attrs, [:view_module, :additional_info, :engagement_time, :session_id])
    |> validate_required([:view_module, :session_id])
  end
end
