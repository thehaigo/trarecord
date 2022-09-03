defmodule Trarecord.Repo do
  use Ecto.Repo,
    otp_app: :trarecord,
    adapter: Ecto.Adapters.Postgres
end
