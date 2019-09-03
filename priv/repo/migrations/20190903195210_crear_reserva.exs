defmodule Flashtiket.Repo.Migrations.CrearReserva do
  use Ecto.Migration

  def change do
    create table(:reservas) do
      add :cc, :string
      add :id_planilla, :string
      add :puesto, :string
      add :descripcion, :string, default: "debe todo"
      add :estado, :string, default: "reservado"
      timestamps()
    end
    create unique_index(:reservas, [:id_planilla, :puesto])
  end
end
