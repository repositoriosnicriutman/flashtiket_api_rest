defmodule Flashtiket.Planillas do
  use Ecto.Schema

  schema "planillas" do
    field :fecha, :string
    field :hora, :string
    field :codigo, :string
    field :conductor, :string
    field :vehiculo, :string
    field :estado, :string
    timestamps()
  end
end
