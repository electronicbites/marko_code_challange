defmodule Challenge.Repo.Migrations.CreateTrackingPageViews do
  use Ecto.Migration

  def change do
    create table(:tracking_page_views) do
      add :view_module, :string
      add :additional_info, :map
      add :engagement_time, :integer
      add :session_id, references(:tracking_sessions, on_delete: :delete_all)

      timestamps()
    end

    create index(:tracking_page_views, [:session_id])
  end
end
