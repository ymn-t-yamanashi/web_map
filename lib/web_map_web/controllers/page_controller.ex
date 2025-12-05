defmodule WebMapWeb.PageController do
  use WebMapWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
