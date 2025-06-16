defmodule ApiDocExplorations.Repo do
  use Ecto.Repo,
    otp_app: :api_doc_explorations,
    adapter: Ecto.Adapters.Postgres
end
