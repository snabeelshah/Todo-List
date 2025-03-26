defmodule Todoest.Repo do
  use Ecto.Repo,
    otp_app: :todoest,
    adapter: Ecto.Adapters.Postgres
end
