defmodule Departures.Feed.Train do
  use Ecto.Schema
  import Ecto.Changeset
  alias Departures.Feed.Train


  schema "trains" do
    field :Destination, :string,   source: :destination
    field :Lateness, :integer,     source: :lateness
    field :Origin, :string,        source: :origin
    field :ScheduledTime, :integer,source: :scheduled
    field :Status, :string,        source: :status
    field :Track, :integer,        source: :track
    field :Trip, :integer,         source: :trip
    field :TimeStamp, :integer,    source: :ts

    timestamps()
  end

  @doc false
  def changeset(%Train{} = train, attrs) do
    train
    |> cast(attrs, [:TimeStamp, :Origin, :Trip, :Destination, :ScheduledTime, :Lateness, :Track, :Status])
    |> validate_required([:TimeStamp, :Origin, :Trip, :Destination, :ScheduledTime, :Lateness, :Status])
  end
end
