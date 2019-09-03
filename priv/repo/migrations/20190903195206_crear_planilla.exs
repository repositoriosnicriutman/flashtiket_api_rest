defmodule Flashtiket.Repo.Migrations.CrearPlanilla do
  use Ecto.Migration

  def change do
    create table(:planillas) do
      add :fecha, :string
      add :hora, :string
      add :codigo, :string
      add :conductor, :string, default: "pendiente"
      add :vehiculo, :string, default: "pendiente"
      add :estado, :string, default: "activo"
      timestamps()
    end
    create unique_index(:planillas, [:fecha, :hora, :codigo])
  end
end
