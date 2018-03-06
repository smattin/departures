defmodule Departures.Feed.Train do
  use Ecto.Schema
  import Ecto.Changeset
  alias Departures.Feed.Train


  schema "trains" do
    field :destination, :string
    field :lateness, :integer
    field :origin, :string
    field :scheduled, :integer
    field :status, :string
    field :track, :integer
    field :trip, :integer
    field :ts, :integer

    timestamps()
  end

  @doc false
  def changeset(%Train{} = train, attrs) do
    train
    |> cast(attrs, [:ts, :origin, :trip, :destination, :scheduled, :lateness, :track, :status])
    |> validate_required([:ts, :origin, :trip, :destination, :scheduled, :lateness, :track, :status])
  end
end
