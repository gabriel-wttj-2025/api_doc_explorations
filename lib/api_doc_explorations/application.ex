defmodule ApiDocExplorations.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ApiDocExplorationsWeb.Telemetry,
      ApiDocExplorations.Repo,
      {DNSCluster,
       query: Application.get_env(:api_doc_explorations, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ApiDocExplorations.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ApiDocExplorations.Finch},
      # Start a worker by calling: ApiDocExplorations.Worker.start_link(arg)
      # {ApiDocExplorations.Worker, arg},
      # Start to serve requests, typically the last entry
      ApiDocExplorationsWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ApiDocExplorations.Supervisor]

    case Supervisor.start_link(children, opts) do
      {:ok, pid} ->
        # Generate OpenAPI spec after successful startup
        generate_openapi_spec()
        {:ok, pid}

      error ->
        error
    end
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ApiDocExplorationsWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp generate_openapi_spec do
    try do
      # Generate the spec
      spec = ApiDocExplorationsWeb.ApiSpec.spec()
      json = Jason.encode!(spec, pretty: true)

      # Ensure the directory exists
      File.mkdir_p!("priv/static")

      # Write the OpenAPI spec to a file
      File.write!("priv/static/openapi.json", json)

      IO.puts("✅ OpenAPI spec generated at priv/static/openapi.json")
    rescue
      error ->
        IO.puts("❌ Failed to generate OpenAPI spec: #{inspect(error)}")
    end
  end
end
