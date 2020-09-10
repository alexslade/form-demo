defmodule FormicWeb.PageController do
  use FormicWeb, :controller

  def confirmation(conn, _params) do
    render(conn, "confirmation.html")
  end
end
