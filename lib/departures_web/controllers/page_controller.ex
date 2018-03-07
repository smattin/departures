defmodule DeparturesWeb.PageController do
  use DeparturesWeb, :controller
  alias Departures.Feed

  def index(conn, _params) do
    # TODO parameterize origin station

    origin = "North Station"
    # TODO: check the dates of the trains ScheduledTime, which might not be today
    Feed.clear()
    Feed.update() 
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

    now = Calendar.DateTime.now! boston

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
      {hh,meridian} = 
        if hh > 12 do
          {hh - 12, "PM"}
        else
          {hh, "AM"}
        end
      List.to_string(:io_lib.format('~2.. w:~2..0w', [hh,mm])) <> " " <> meridian
  end
end
