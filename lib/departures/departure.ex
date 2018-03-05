defmodule Departures.Departure do
  use Ecto.Schema
  import Ecto.Changeset
  alias Departures.Departure


  schema "departures" do
    field :carrier, :string
    field :departs, :utc_datetime
    field :destination, :string
    field :status, :string
    field :track, :integer
    field :train, :integer

    timestamps()
  end

  @doc false
  def changeset(%Departure{} = departure, attrs) do
    departure
    |> cast(attrs, [:carrier, :departs, :destination, :train, :track, :status])
    |> validate_required([:carrier, :departs, :destination, :train, :status])
  end
end
