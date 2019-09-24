defmodule FlashtiketWeb.PlanillaController do
  use FlashtiketWeb, :controller
  alias Flashtiket.PlanillasConsulta
  alias FlashtiketWeb.PlanillaView
  @moduledoc """
  crear, obtiene, actualiza, y elimina las planillas devolviendo un json
  """

  action_fallback(FlashtiketWeb.FallbackControler)

  @doc """
    crea una planilla con los fecha hora, codigo y devuelve un json con los datos
  """
  @spec crear(map, map) :: tuple
  def crear(_conn, %{"planilla" => datos_planilla}) do
    with {:ok, planilla} <- PlanillasConsulta.crear_planilla(datos_planilla) do
          {:success, PlanillaView, "show.json", planilla: planilla}
    end
  end

 @doc """
    busca una planilla por el id_planilla y devuelve un json con los datos
  """
  @spec obtener_id(map, map) :: tuple
  def obtener_id(_conn, %{"id" => id_planilla}) do
    with planilla <- PlanillasConsulta.consultar_id(String.to_integer id_planilla) do
      {:success, PlanillaView, "show.json", planilla: planilla}
     end
  end

  @doc """
    busca todas planilla asociadas a una fecha y devuelve un json con los datos
  """
  @spec obtener_fecha(map, map) :: tuple
  def obtener_fecha(_conn, %{"fecha" => fecha_planilla}) do
    with planilla <- PlanillasConsulta.consultar_fecha(fecha_planilla) do
      {:success, PlanillaView, "show_coleccion.json", planilla: planilla}
     end
  end

  @doc """
    busca todas planilla asociadas a una fecha, hora y devuelve un json con los datos
  """
  @spec obtener_fecha_y_hora(map, map) :: tuple
  def obtener_fecha_y_hora(_conn, %{"fecha" => fecha_planilla, "hora" => hora_planilla}) do
    with planilla <- PlanillasConsulta.consultar_fecha_y_hora(fecha_planilla, hora_planilla) do
      {:success, PlanillaView, "show_coleccion.json", planilla: planilla}
     end
  end

  @doc """
    busca una planilla asociadas a una fecha, hora, codigo y devuelve un json con los datos
  """
  @spec obtener_fecha_hora_y_codigo(map, map) :: tuple
  def obtener_fecha_hora_y_codigo(_conn, %{"fecha" => fecha_planilla, "hora" => hora_planilla, "codigo" => codigo_planilla}) do
    with planilla <- PlanillasConsulta.consultar_fecha_hora_y_codigo(fecha_planilla, hora_planilla, codigo_planilla) do
      IO.inspect planilla
      {:success, PlanillaView, "show.json", planilla: planilla}
     end
  end

  @doc """
    busca todas planilla con estado activo y devuelve un json con los datos
  """
  @spec obtener_activa(map, map) :: tuple
  def obtener_activa(_conn, _params) do
    with planilla <- PlanillasConsulta.consultar_activa() do
      {:success, PlanillaView, "show_coleccion.json", planilla: planilla}
    end
  end

  @doc """
    aztualiza una planilla en los campos conductor, vehiculo, estado y devuelve un json con los datos
  """
  @spec actualizar(map, map) :: tuple
  def actualizar(_conn, %{"planilla" => datos_planilla}) do
    with {:ok, planilla} <- PlanillasConsulta.actualizar_planilla(datos_planilla) do
          {:success, PlanillaView, "show.json", planilla: planilla}
    end
  end

  @doc """
    elimina una planilla por el id
  """
  @spec borrar(map, map) :: tuple
  def borrar(_conn, %{"id" => id_planilla}) do
    with {:ok, planilla} <- PlanillasConsulta.borrar_planilla(String.to_integer id_planilla) do
         {:success, PlanillaView, "show.json", planilla: planilla}
    end
  end

end
