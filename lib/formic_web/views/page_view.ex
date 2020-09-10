defmodule FormicWeb.PageView do
  use FormicWeb, :view

  def active?(conn, path) do
    if Phoenix.Controller.current_path(conn) == path do
      "active"
    else
      ""
    end
  end
end
