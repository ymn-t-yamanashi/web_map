defmodule WebMapWeb.MapController do
  use WebMapWeb, :controller
  alias WebMap.EtsMap

  def insert(conn, params) do
    EtsMap.insert(params)
    |> Integer.to_string()
    |> plain(conn)
  end

  def get(conn, %{"id" => id, "key" => key}) do
    String.to_integer(id)
    |> EtsMap.get()
    |> Map.get(key, "")
    |> plain(conn)
  end

  def delete(conn, %{"id" => id}) do
    String.to_integer(id)
    |> EtsMap.delte()
    |> inspect()
    |> plain(conn)
  end

  defp plain(body, conn) do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, body)
  end
end
