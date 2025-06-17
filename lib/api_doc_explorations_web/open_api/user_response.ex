defmodule ApiDocExplorationsWeb.OpenApi.UserResponse do
  require OpenApiSpex

  OpenApiSpex.schema(%{
    title: "UserResponse",
    type: :object,
    properties: %{
      id: %OpenApiSpex.Schema{type: :integer, example: 1},
      name: %OpenApiSpex.Schema{type: :string, example: "Alice"},
      email: %OpenApiSpex.Schema{type: :string, example: "alice@example.com"}
    },
    required: [:id, :name, :email]
  })
end
