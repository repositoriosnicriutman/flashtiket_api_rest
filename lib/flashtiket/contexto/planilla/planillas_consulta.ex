defmodule Flashtiket.PlanillasConsulta do
  alias Flashtiket.Planillas
  alias Flashtiket.Repo
  import Ecto.Changeset
  import Ecto.Query


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

  def changeset(%Planillas{} = planilla, params \\ %{}) do
    planilla
      |> cast(params, @datos)
      |> validate_required(@datos)
      |> unique_constraint(:fecha, name: :planillas_fecha_hora_codigo_index)
  end

  def actualizar_changeset(%Planillas{} = planilla, params \\ %{}) do
    planilla
      |> cast(params, @actualizar_datos)
      |> validate_required(@actualizar_datos)
  end

  def crear_planilla(parametros) do
    %Planillas{}
    |> changeset(parametros)
    |> Repo.insert()
  end

  def consultar_id(id) do
    query = from u in Planillas,
            where: u.id == ^id,
            select: u
    Repo.one(query)
  end

  def consultar_fecha(fecha) do
    query = from u in Planillas,
            where: u.fecha == ^fecha,
            select: u
    Repo.all(query)
  end

  def consultar_fecha_y_hora(fecha, hora) do
    query = from u in Planillas,
            where: u.fecha == ^fecha
            and u.hora == ^hora,
            select: u
    Repo.all(query)
  end

  def consultar_fecha_hora_y_codigo(fecha, hora, codigo) do
    query = from u in Planillas,
            where: u.fecha == ^fecha
            and u.hora == ^hora
            and u.codigo == ^codigo,
            select: u
    Repo.one(query)
  end

  def consultar_activa() do
    query = from u in Planillas,
            where: u.estado == "activo",
            select: u
    Repo.all(query)
  end

  def actualizar_planilla(parametros) do
    %Planillas{id: parametros["id"]}
    |> actualizar_changeset(parametros)
    |> Repo.update()
  end

  def borrar_planilla(id) do
    %Planillas{id: id}
    |>Repo.delete()
  end

end
