defmodule ApiDocExplorations.Accounts do
  alias ApiDocExplorations.Repo
  alias ApiDocExplorations.Accounts.User

  def create_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
