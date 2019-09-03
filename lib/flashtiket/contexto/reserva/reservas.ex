defmodule Flashtiket.Reservas do
  use Ecto.Schema

  schema "reservas" do
    field :cc, :string
    field :id_planilla, :string
    field :puesto, :string
    field :descripcion, :string
    field :estado, :string
    timestamps()
  end
end
