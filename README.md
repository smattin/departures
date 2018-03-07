# Departures

#### MBTA coding demo

build a super simple application that shows the live train departure times? It should hopefully be pretty straightforward. The instructions for where to find the real-time data are in this document: http://www.mbta.com/uploadedfiles/Departure%20Board%20Feed.pdf. Just to give you an idea, this is what the real departure board at North Station looks like: https://commons.wikimedia.org/wiki/File:North_Station_departure_board.JPG

This may not be "super simple" at the moment, since it includes a Postgres database
```
docker run --name mbta-postgres -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 postgres
```
and it has a bunch of stuff used for incremental development, like a scheme for the displayed board data, departures/lib/departures/departure.ex, not strictly needed.

The guts of the implementation are in:

  * departures/lib/departures/feed/feed.ex
  * departures_web/controllers/page_controller.ex
  * departures_web/templates/page/index.html.eex


### stock Phoenix README

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
