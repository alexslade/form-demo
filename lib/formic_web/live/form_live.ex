defmodule FormicWeb.FormLive do
  use FormicWeb, :live_view

  @impl true
  def mount(_params, %{"_csrf_token" => csrf_token}, socket) do
    changeset = Formic.Form.changeset()
    {:ok, assign(socket, changeset: changeset, csrf_token: csrf_token)}
  end

  @impl true
  def handle_event("validate", %{"form" => params}, socket) do
    changeset =
      %Formic.Form{}
      |> Formic.Form.changeset(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  @impl true
  def handle_event("save", %{"form" => params}, socket) do
    changeset =
      %Formic.Form{}
      |> Formic.Form.changeset(params)
      |> Map.put(:action, :insert)
      |> Map.put(:event_ref, make_ref)

    {:noreply, assign(socket, changeset: changeset)}
  end
end
