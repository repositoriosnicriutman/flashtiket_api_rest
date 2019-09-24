defmodule Flashtiket.ReservasConsulta do
  alias Flashtiket.Reservas
  alias Flashtiket.Repo
  import Ecto.Changeset
  import Ecto.Query
   @moduledoc """
    comprueba datos y hace consultas para las reservas
  """

  @datos [
    :cc,
    :id_planilla,
    :puesto
  ]

  @actualizar_datos [
    :descripcion,
    :estado
  ]

  @doc """
    comprueba los campos cc, id_planilla y puesto para crear una reserva
  """
  @spec changeset(struct, map) :: tuple
  def changeset(%Reservas{} = reserva, params \\ %{}) do
    reserva
      |> cast(params, @datos)
      |> validate_required(@datos)
      |> unique_constraint(:puesto, name: :reservas_id_planilla_puesto_index)
  end

 @doc """
    comprueba los campos descripcion y estado para actualizar una reserva
  """
  @spec actualizar_changeset(struct, map) :: tuple
  def actualizar_changeset(%Reservas{} = reserva, params \\ %{}) do
    reserva
      |> cast(params, @actualizar_datos)
      |> validate_required(@actualizar_datos)
  end

   @doc """
    crear una reserva con los campos cc, id_planilla, puesto
  """
  @spec crear_reserva(map) :: struct
  def crear_reserva(parametros) do
    %Reservas{}
    |>changeset(parametros)
    |>Repo.insert()
  end

  @doc """
    busca una reserva por cc
  """
  @spec consultar_cc(char) :: struct
  def consultar_cc(cc) do
    query = from u in Reservas,
            where: u.cc == ^cc,
            select: u
    Repo.all(query)
  end

  @doc """
    busca una reserva por id_planilla
  """
  @spec consultar_id(integer) :: struct
  def consultar_id(id) do
    query = from u in Reservas,
            where: u.id_planilla == ^id,
            select: u
    Repo.all(query)
  end

  @doc """
    busca una reserva por id_planilla y puesto
  """
  @spec consultar_id_y_puesto(char, char) :: struct
  def consultar_id_y_puesto(id, puesto) do
    query = from u in Reservas,
            where: u.id_planilla == ^id
            and u.puesto == ^puesto,
            select: u
    Repo.one(query)
  end

  @doc """
    actualiza los campos descripcion y estado de una reserva
  """
  @spec actualizar_reserva(map) :: struct
  def actualizar_reserva(parametros) do
    %Reservas{id: parametros["id"]}
    |>actualizar_changeset(parametros)
    |>Repo.update()
  end

   @doc """
    elimina una reserva por el campo id
  """
  @spec borrar_reserva(integer) :: struct
  def borrar_reserva(id) do
    %Reservas{id: id}
    |>Repo.delete()
  end

end
