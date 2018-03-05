# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Departures.Repo.insert!(%Departures.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Departures.Repo
alias Departures.Departure

Enum.each([
    %Departure{carrier: "Amtrak", departs: elem(Elixir.DateTime.from_iso8601("2011-12-11 18:45:00-05:00"),1),destination: "Portland, ME", train: 695, status: "on time"},
    %Departure{carrier: "MBTA", departs: elem(Elixir.DateTime.from_iso8601("2011-12-11 19:15:00-05:00"),1),destination: "Newburyport, MA", train: 2169, status: "on time"},
    %Departure{carrier: "MBTA", departs: elem(Elixir.DateTime.from_iso8601("2011-12-11 20:00:00-05:00"),1),destination: "Lowell, MA", train: 2313, status: "on time"},
    %Departure{carrier: "MBTA", departs: elem(Elixir.DateTime.from_iso8601("2011-12-11 20:00:00-05:00"),1),destination: "Fitchberg, MA", train: 2413, status: "on time"},
    %Departure{carrier: "MBTA", departs: elem(Elixir.DateTime.from_iso8601("2011-12-11 20:30:00-05:00"),1),destination: "Rockport, MA", train: 2121, status: "on time"},
    %Departure{carrier: "MBTA", departs: elem(Elixir.DateTime.from_iso8601("2011-12-11 20:40:00-05:00"),1),destination: "Haverhill, MA", train: 2221, status: "on time"},
    %Departure{carrier: "MBTA", departs: elem(Elixir.DateTime.from_iso8601("2011-12-11 22:15:00-05:00"),1),destination: "Newburyport, MA", train: 2173, status: "on time"},
    %Departure{carrier: "Amtrak", departs: elem(Elixir.DateTime.from_iso8601("2011-12-11 23:00:00-05:00"),1),destination: "Portland, ME", train: 699, status: "on time"},
    %Departure{carrier: "MBTA", departs: elem(Elixir.DateTime.from_iso8601("2011-12-11 23:30:00-05:00"),1),destination: "Rockport, MA", train: 2125, status: "on time"}
], fn(x) -> Repo.insert!(x) end)
