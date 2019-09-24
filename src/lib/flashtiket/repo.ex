defmodule Flashtiket.Repo do
  use Ecto.Repo,
    otp_app: :flashtiket,
    adapter: Ecto.Adapters.Postgres
end
