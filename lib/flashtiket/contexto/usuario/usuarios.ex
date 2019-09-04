defmodule Flashtiket.Usuarios do
  use Ecto.Schema

  schema "usuarios" do
    has_many :auth_tokens, Flashtiket.AuthToken
    field :nombre, :string
    field :cc, :string
    field :celular, :string
    field :email, :string
    field :encrypted_password, :string
    field :password, :string,  virtual: true
    field :rol, :string
    timestamps()
  end
end
