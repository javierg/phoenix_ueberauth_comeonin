# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :phoenix_ueberauth_comeonin,
  ecto_repos: [PhoenixUeberauthComeonin.Repo]

# Configures the endpoint
config :phoenix_ueberauth_comeonin, PhoenixUeberauthComeonin.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "mMQiDgCa8kxUWa07TYR48pkAu6zvpOfBw16DvjP4pUMoaHjtkRnxHwHRACCtSwNC",
  render_errors: [view: PhoenixUeberauthComeonin.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PhoenixUeberauthComeonin.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# secret_key value is a sample, it is better set on an ENV variable or from a local file.
config :guardian, Guardian,
  allowed_algos: ["HS512"],
  verify_module: Guardian.JWT,
  issuer: "Metamorfo",
  ttl: { 30, :days },
  verify_issuer: true,
  secret_key: <<188, 78, 156, 202, 219, 17, 166, 68, 84, 206, 109, 204, 103, 136, 108,
        222>>,
  serializer: GuardianSerializer

config :ueberauth, Ueberauth,
  providers: [
    identity: { Ueberauth.Strategy.Identity, [
        callback_methods: ["POST"],
        uid_field: :email,
        nickname_field: :email,
        request_path: "/sessions/new",
        callback_path: "/sessions/identity/callback",
      ]}
  ]
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
