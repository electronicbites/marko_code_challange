defmodule Challenge.Repo.Migrations.CreateTrackingSessions do
  use Ecto.Migration

  def change do
    create table(:tracking_sessions) do
      add :browser_agent, :string
      add :cookie_id, :string

      timestamps()
    end

    create index(:tracking_sessions, [:cookie_id])
  end
end
