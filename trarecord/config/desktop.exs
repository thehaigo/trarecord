import Config

# Configures the endpoint
config :trarecord, TrarecordWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 0],
  render_errors: [view: TrarecordWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Trarecord.PubSub,
  live_view: [signing_salt: "nt9pr/6W"],
  secret_key_base: "cVZaz98CBZNGr4dk7XhVqYpW49We6OKdzORLS20peE0ZK8Qv3ex6uOLujx/mXS80",
  server: true
