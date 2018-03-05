defmodule DeparturesWeb.PageController do
  use DeparturesWeb, :controller
  import Ecto.Query, only: [from: 2]

  def index(conn, _params) do

    # FIXME cast to local time
    now = elem(Elixir.DateTime.from_iso8601("2011-12-11 18:28:00-05:00"),1)

    query = from d in Departures.Departure, 
      select: [d.carrier,fragment("to_char(?, 'HH:MI')",d.departs),d.destination,d.train,fragment("COALESCE(to_char(?,'99'),'TBD')",d.track),d.status],
      where: d.departs >= ^now,
      limit: 9
      departures = Departures.Repo.all(query) 
      render(conn, "index.html", now: now, departures: departures)
  end

  def dayname(dt) do
      weekday = Date.day_of_week(DateTime.to_date(dt))
      day_names = {:error,"Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"}
      elem(day_names,weekday)
  end

  def date_mdy(dt) do
      {yyyy,mm,dd} = Date.to_erl(DateTime.to_date(dt))
      List.to_string(:io_lib.format('~2..0b/~2..0b/~4..0b', [mm,dd,yyyy]))
  end

  def time_hm(dt) do
      {hh,mm,_ss} = Time.to_erl(DateTime.to_time(dt))
      List.to_string(:io_lib.format('~2..0b:~2..0b', [hh,mm]))
  end
end
