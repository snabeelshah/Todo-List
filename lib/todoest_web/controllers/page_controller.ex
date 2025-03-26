defmodule TodoestWeb.PageController do
  use TodoestWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end
end