defmodule Formic.Repo do
  use Ecto.Repo,
    otp_app: :formic,
    adapter: Ecto.Adapters.Postgres
end
