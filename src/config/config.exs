# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :flashtiket,
  ecto_repos: [Flashtiket.Repo]


config :flashtiket, Flashtiket.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: "smtp.gmail.com",
  hostname: "localhost",
  port: 465,
  username: "nicriutmanplay@gmail.com", # or {:system, "SMTP_USERNAME"}
  password: "3153356923stevan", # or {:system, "SMTP_PASSWORD"}
  tls: :if, # can be `:always` or `:never`
  allowed_tls_versions: [:"tlsv1", :"tlsv1.1", :"tlsv1.2"], # or {:system, "ALLOWED_TLS_VERSIONS"} w/ comma seprated values (e.g. "tlsv1.1,tlsv1.2")
  ssl: true, # can be `true`
  retries: 1,
  no_mx_lookups: false, # can be `true`
  auth: :if # can be `always`. If your smtp relay requires authentication set it to `always`.


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
