defmodule User do
  use PhoenixUeberauthComeonin.Web, :model

  import Comeonin.Bcrypt

  alias Ueberauth.Auth
  alias PhoenixUeberauthComeonin.Repo

  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string

    timestamps()
  end

  def authenticate(%Auth{provider: :identity} = auth) do
    Repo.get_by(__MODULE__, email: auth.uid)
    |> authorize(auth)
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email])
    |> validate_required([:name, :email])
  end

  defp authorize(nil,_auth), do: {:error, "Invalid username or password"}
  defp authorize(user, auth) do
    checkpw(auth.credentials.other.password, user.password)
    |> resolve_authorization(user)
  end

  defp resolve_authorization(false, _user), do: {:error, "Invalid username or password"}
  defp resolve_authorization(true, user), do: {:ok, user}
end

