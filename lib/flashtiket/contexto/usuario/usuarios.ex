defmodule Flashtiket.Usuarios do
  use Ecto.Schema

  schema "usuarios" do
    field :nombre, :string
    field :cc, :string
    field :celular, :string
    field :usuario, :string
    field :encrypted_password, :string
    field :password, :string,  virtual: true
    field :rol, :string
    timestamps()
  end
end
