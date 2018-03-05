defmodule Departures.Repo.Migrations.DepartsUtcDatetime do
  use Ecto.Migration

  def change do
    alter table(:departures) do
      modify :departs, :utc_datetime
    end
  end
end
