defmodule ApiDocExplorationsWeb.OpenApi.ErrorResponse do
  require OpenApiSpex

  OpenApiSpex.schema(%{
    title: "ErrorResponse",
    type: :object,
    properties: %{
      errors: %OpenApiSpex.Schema{type: :object}
    }
  })
end
