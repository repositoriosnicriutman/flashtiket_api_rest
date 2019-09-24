defmodule Flashtiket.AuthToken do
    use Ecto.Schema
    import Ecto.Changeset
    alias Flashtiket.AuthToken
    alias Flashtiket.Usuarios

  schema "auth_tokens" do
      belongs_to :usuarios, Usuarios
      field :revoked, :boolean, default: false
      field :revoked_at, :utc_datetime
      field :token, :string
      timestamps()
    end
    def changeset(%AuthToken{} = auth_token, attrs) do
      auth_token
      |> cast(attrs, [:token])
      |> validate_required([:token])
      |> unique_constraint(:token)
    end
  end
