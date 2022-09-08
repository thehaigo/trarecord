import Config
# Configures the endpoint

if config_env() == :dev do
  config :trarecord, TrarecordWeb.Endpoint,
    # Binding to loopback ipv4 address prevents access from other machines.
    # Change to `ip: {0, 0, 0, 0}` to allow access from other machines.
    http: [ip: {127, 0, 0, 1}, port: 4000]
end
