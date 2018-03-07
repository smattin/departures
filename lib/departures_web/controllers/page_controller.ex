defmodule DeparturesWeb.PageController do
  use DeparturesWeb, :controller
  import Ecto.Query, only: [from: 2]
  import Departures.Feed
  alias Departures.Feed

  def index(conn, _params) do


    origin = "North Station"    
    trains = Feed.list_trains(origin)
    boston = "America/New_York" # :(
    # "Carrier","Time","Destination","Train#","Track#","Status"]
    departures = Enum.map(trains,fn(x) -> [
        "MBTA",
        time_hm(DateTime.from_unix!(x."ScheduledTime") |> Calendar.DateTime.shift_zone!(boston)),
        x."Destination",
        x."Trip",
        x."Track",
        x."Status"
    ]
    end)

    # FIXME cast to local time
    # now = elem(Elixir.DateTime.from_iso8601("2011-12-11 18:28:00-05:00"),1)
    # now = Elixir.DateTime.utc_now()
    now = Calendar.DateTime.now! boston

"""
    # for sample
    query = from d in Departures.Departure, 
      select: [d.carrier,fragment("to_char(?, 'HH:MI')",d.departs),d.destination,d.train,fragment("COALESCE(to_char(?,'99'),'TBD')",d.track),d.status],
      where: d.departs >= ^now,
      limit: 9
      departures = Departures.Repo.all(query) 
"""
      render(conn, "index.html", now: now, departures: departures)
  end

  def dayname(dt) do
      weekday = Date.day_of_week(DateTime.to_date(dt))
      day_names = {:error,"Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"}
      elem(day_names,weekday)
  end

  def date_mdy(dt) do
      {yyyy,mm,dd} = Date.to_erl(DateTime.to_date(dt))
      List.to_string(:io_lib.format('~w/~w/~w', [mm,dd,yyyy]))
  end

  def time_hm(dt) do
      {hh,mm,_ss} = Time.to_erl(DateTime.to_time(dt))
      meridian = "AM"
      if hh > 12 do
        hh = hh - 12
        meridian = "PM"
      end
      List.to_string(:io_lib.format('~2.. w:~2..0w', [hh,mm])) <> " " <> meridian
  end
end
