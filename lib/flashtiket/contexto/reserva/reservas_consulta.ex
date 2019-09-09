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
      |> unique_constraint(:puesto, name: :reservas_id_planilla_puesto_index)
  end

  def crear_reserva(parametros) do
    %Reservas{}
    |>changeset(parametros)
    |>Repo.insert()
  end

  def consultar_cc(cc) do
    query = from u in Reservas,
            where: u.cc == ^cc,
            select: u
    Repo.all(query)
  end

  def consultar_id(id) do
    query = from u in Reservas,
            where: u.id_planilla == ^id,
            select: u
    Repo.all(query)
  end

  def consultar_id_y_puesto(id, puesto) do
    query = from u in Reservas,
            where: u.id_planilla == ^id
            and u.puesto == ^puesto,
            select: u
    Repo.one(query)
  end

  def actualizar_reserva(parametros) do
    %Reservas{id: parametros["id"]}
    |>changeset(parametros)
    |>Repo.update()
  end

  def borrar_reserva(id) do
    Repo.delete(id)
  end

end
