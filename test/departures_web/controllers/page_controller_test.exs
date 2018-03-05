defmodule DeparturesWeb.PageControllerTest do
  use DeparturesWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "North Station Departures"
  end
end
