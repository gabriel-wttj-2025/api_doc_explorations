defmodule ApiDocExplorationsWeb.UserController do
  use ApiDocExplorationsWeb, :controller
  use OpenApiSpex.ControllerSpecs

  alias ApiDocExplorations.Accounts
  alias ApiDocExplorationsWeb.OpenApi.{UserRequest, UserResponse, ErrorResponse}

  tags(["User"])

  operation(:create,
    summary: "Create a new user",
    request_body: {"User params", "application/json", UserRequest},
    responses: [
      created: {"User created", "application/json", UserResponse},
      unprocessable_entity: {"Validation errors", "application/json", ErrorResponse}
    ]
  )

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> json(%{id: user.id, name: user.name, email: user.email})

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: changeset.errors})
    end
  end

  operation(:show,
    summary: "Get a user by ID",
    parameters: [
      id: [in: :path, description: "User ID", type: :string, example: "123"]
    ],
    responses: [
      ok: {"User found", "application/json", UserResponse},
      not_found: {"User not found", "application/json", ErrorResponse}
    ]
  )

  def show(conn, %{"id" => id}) do
    case Accounts.get_user(id) do
      {:ok, user} ->
        conn
        |> put_status(:ok)
        |> json(%{id: user.id, name: user.name, email: user.email})

      {:error, :not_found} ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "User not found"})
    end
  end
end
