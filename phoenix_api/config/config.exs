# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :phoenix_api,
  ecto_repos: [PhoenixApi.Repo]

# Configures the endpoint
config :phoenix_api, PhoenixApi.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Qn8CAQyOgaHae5ni4YpO5ADV26V4gfCeyBedlEBcZiCsRE2QoOoLLQzBG2mUCAfz",
  render_errors: [view: PhoenixApi.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PhoenixApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :plug, :mimes, %{
 "application/vnd.api+json" => ["json-api"]
}

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :ja_serializer,
  key_format: :underscored
  
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
