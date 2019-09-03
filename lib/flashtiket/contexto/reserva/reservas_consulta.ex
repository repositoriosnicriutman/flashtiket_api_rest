defmodule Flashtiket.ReservasConsulta do
  alias Flashtiket.Reservas
  alias Flashtiket.Repo
  import Ecto.Changeset
  import Ecto.Query

  @datos [
    :cc,
    :id_planilla,
    :puesto,
    :descripcion,
    :estado
  ]

  def changeset(%Reservas{} = reserva, params \\ %{}) do
    reserva
      |> cast(params, @datos)
      |> validate_required(@datos)
  end

  def crear_reserva(changeset) do
    Repo.insert(changeset)
  end

  def consultar_cc(cc) do
    query = from u in Flashtiket.Reservas,
            where: u.cc == ^cc,
            select: u
    Repo.all(query)
  end

  def consultar_id(id) do
    query = from u in Flashtiket.Reservas,
            where: u.id_planilla == ^id,
            select: u
    Repo.all(query)
  end

  def actualizar_reserva(changeset) do
    Repo.update(changeset)
  end

  def borrar_reserva(changeset) do
    Repo.delete(changeset)
  end
end
