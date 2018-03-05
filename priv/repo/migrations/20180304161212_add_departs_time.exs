defmodule Departures.Repo.Migrations.AddDepartsTime do
  use Ecto.Migration

  def change do

    alter table(:departures) do
      add :departs, :datetime
    end
  end
end
