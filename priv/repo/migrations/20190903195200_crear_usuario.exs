defmodule Flashtiket.Repo.Migrations.CrearUsuario do
  use Ecto.Migration

  def change do
    create table(:usuarios) do
      add :nombre, :string
      add :cc, :string
      add :celular, :string
      add :email, :string
      add :encrypted_password, :string
      add :rol, :string, default: "cliente"
      timestamps()
    end
    create unique_index(:usuarios, [:email])
  end
end
