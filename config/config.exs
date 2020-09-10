# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :formic,
  ecto_repos: [Formic.Repo]

# Configures the endpoint
config :formic, FormicWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "XEqqEV9423MQfkilrvCkLbYi2nmRj1GHpcUb0j/q4wjEsrFZHOps/v2VhXFNx/SW",
  render_errors: [view: FormicWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Formic.PubSub,
  live_view: [signing_salt: "2ltKRaLy"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
