defmodule ApiDocExplorationsWeb.OpenApi.UserRequest do
  require OpenApiSpex

  OpenApiSpex.schema(%{
    title: "UserRequest",
    type: :object,
    properties: %{
      user: %OpenApiSpex.Schema{
        type: :object,
        properties: %{
          name: %OpenApiSpex.Schema{type: :string, example: "Alice"},
          email: %OpenApiSpex.Schema{type: :string, example: "alice@example.com"}
        },
        required: [:name, :email]
      }
    },
    required: [:user]
  })
end
