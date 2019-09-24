defmodule Flashtiket.PlanillasConsulta do
  alias Flashtiket.Planillas
  alias Flashtiket.Repo
  import Ecto.Changeset
  import Ecto.Query
  @moduledoc """
    comprueba datos y hace consultas para las planillas
  """


  @datos [
    :fecha,
    :hora,
    :codigo
  ]

  @actualizar_datos [
    :conductor,
    :vehiculo,
    :estado
  ]

  @doc """
    comprueba los campos fecha, hora y codigo para crear una planilla
  """
  @spec changeset(struct, map) :: tuple
  def changeset(%Planillas{} = planilla, params \\ %{}) do
    planilla
      |> cast(params, @datos)
      |> validate_required(@datos)
      |> unique_constraint(:fecha, name: :planillas_fecha_hora_codigo_index)
  end

  @doc """
    comprueba los campos vehiculo, conductor y estado para actualizar una planilla
  """
  @spec actualizar_changeset(struct, map) :: tuple
  def actualizar_changeset(%Planillas{} = planilla, params \\ %{}) do
    planilla
      |> cast(params, @actualizar_datos)
      |> validate_required(@actualizar_datos)
  end

  @doc """
    crear una planilla con los campos fecha, hora, codigo
  """
  @spec crear_planilla(map) :: struct
  def crear_planilla(parametros) do
    %Planillas{}
    |> changeset(parametros)
    |> Repo.insert()
  end

  @doc """
    busca una planilla por id
  """
  @spec consultar_id(integer) :: struct
  def consultar_id(id) do
    query = from u in Planillas,
            where: u.id == ^id,
            select: u
    Repo.one(query)
  end

  @doc """
    busca una planilla por fecha
  """
  @spec consultar_fecha(char) :: struct
  def consultar_fecha(fecha) do
    query = from u in Planillas,
            where: u.fecha == ^fecha,
            select: u
    Repo.all(query)
  end

  @doc """
    busca una planilla por fecha y hora
  """
  @spec consultar_fecha_y_hora(char, char) :: struct
  def consultar_fecha_y_hora(fecha, hora) do
    query = from u in Planillas,
            where: u.fecha == ^fecha
            and u.hora == ^hora,
            select: u
    Repo.all(query)
  end

  @doc """
    busca una planilla por fecha y hora
  """
  @spec consultar_fecha_hora_y_codigo(char, char, char) :: struct
  def consultar_fecha_hora_y_codigo(fecha, hora, codigo) do
    query = from u in Planillas,
            where: u.fecha == ^fecha
            and u.hora == ^hora
            and u.codigo == ^codigo,
            select: u
    Repo.one(query)
  end

  @doc """
    busca todas as planilla con estado activo
  """
  @spec consultar_activa() :: struct
  def consultar_activa() do
    query = from u in Planillas,
            where: u.estado == "activo",
            select: u
    Repo.all(query)
  end

  @doc """
    actualiza los campos conductor, vehiculo y estado de una planilla
  """
  @spec actualizar_planilla(map) :: struct
  def actualizar_planilla(parametros) do
    %Planillas{id: parametros["id"]}
    |> actualizar_changeset(parametros)
    |> Repo.update()
  end

  @doc """
    elimina una planilla por el campo id
  """
  @spec borrar_planilla(integer) :: struct
  def borrar_planilla(id) do
    %Planillas{id: id}
    |>Repo.delete()
  end

end
