defmodule Departures.Repo.Migrations.CreateDepartures do
  use Ecto.Migration

  def change do
    create table(:departures) do
      add :carrier, :string
      add :destination, :string
      add :train, :integer
      add :track, :integer
      add :status, :string

      timestamps()
    end

  end
end
