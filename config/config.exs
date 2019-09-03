# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :flashtiket,
  ecto_repos: [Flashtiket.Repo]

config :flashtiket, FlashtiketWeb.Auth.Guardian,
  issuer: "flashtiket",
  secret_key: "RtqvQo42AZw5yTaI2Q0/E3HGjNmUUJGcYZlOJQckzzvSHLOhPpPnQr8KWvloW3I2"

# Configures the endpoint
config :flashtiket, FlashtiketWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "nNsSemxH16M8y4Myie5/WfBkz7nIOwZJbjYR2pDZVvgXQjma299d7acvZYnv2XsD",
  render_errors: [view: FlashtiketWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Flashtiket.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
