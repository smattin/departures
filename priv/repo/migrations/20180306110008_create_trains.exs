defmodule Departures.Repo.Migrations.CreateTrains do
  use Ecto.Migration

  def change do
    create table(:trains) do
      add :ts, :integer
      add :origin, :string
      add :trip, :integer
      add :destination, :string
      add :scheduled, :integer
      add :lateness, :integer
      add :track, :integer
      add :status, :string

      timestamps()
    end

  end
end
