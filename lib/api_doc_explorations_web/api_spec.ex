defmodule ApiDocExplorationsWeb.ApiSpec do
  @moduledoc false

  alias OpenApiSpex.{Info, OpenApi, Paths, Server}
  alias ApiDocExplorationsWeb.{Endpoint, Router}
  @behaviour OpenApiSpex.Spec

  @impl OpenApiSpex.Spec
  def spec do
    %OpenApi{
      servers: [
        Server.from_endpoint(Endpoint)
      ],
      info: %Info{
        title: "API Doc Explorations",
        version: "1.0.0"
      },
      paths: Paths.from_router(Router)
    }
    |> OpenApiSpex.resolve_schema_modules()
  end
end
