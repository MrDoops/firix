defmodule FilixWeb.PageController do
  use FilixWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
