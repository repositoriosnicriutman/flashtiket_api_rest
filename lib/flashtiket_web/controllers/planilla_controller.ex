defmodule FlashtiketWeb.PlanillaController do
  use FlashtiketWeb, :controller
  alias Flashtiket.Planillas
  alias Flashtiket.PlanillasConsulta
  alias FlashtiketWeb.PlanillaView

  action_fallback(FlashtiketWeb.FallbackControler)

  def crear(_conn, %{"planilla" => datos_planilla}) do
    with {:ok, planilla} <- PlanillasConsulta.crear_planilla(datos_planilla) do
          {:success, PlanillaView, "show.json", planilla: planilla}
    end
  end

  def obtener_id(_conn, %{"id" => id_planilla}) do
    with planilla <- PlanillasConsulta.consultar_id(String.to_integer id_planilla) do
      {:success, PlanillaView, "show.json", planilla: planilla}
     end
  end

  def obtener_fecha(_conn, %{"fecha" => fecha_planilla}) do
    with planilla <- PlanillasConsulta.consultar_fecha(fecha_planilla) do
      {:success, PlanillaView, "show_coleccion.json", planilla: planilla}
     end
  end

  def obtener_fecha_y_hora(_conn, %{"fecha" => fecha_planilla, "hora" => hora_planilla}) do
    with planilla <- PlanillasConsulta.consultar_fecha_y_hora(fecha_planilla, hora_planilla) do
      {:success, PlanillaView, "show_coleccion.json", planilla: planilla}
     end
  end

  def obtener_fecha_hora_y_codigo(_conn, %{"fecha" => fecha_planilla, "hora" => hora_planilla, "codigo" => codigo_planilla}) do
    with planilla <- PlanillasConsulta.consultar_fecha_hora_y_codigo(fecha_planilla, hora_planilla, codigo_planilla) do
      IO.inspect planilla
      {:success, PlanillaView, "show.json", planilla: planilla}
     end
  end

  def obtener_activa(_conn, _params) do
    with planilla <- PlanillasConsulta.consultar_activa() do
      {:success, PlanillaView, "show_coleccion.json", planilla: planilla}
    end
  end

  def actualizar(_conn, %{"planilla" => datos_planilla}) do
    with {:ok, planilla} <- PlanillasConsulta.actualizar_planilla(datos_planilla) do
          {:success, PlanillaView, "show.json", planilla: planilla}
    end
  end

  def borrar(_conn, %{"id" => id_planilla}) do
    with {:ok, planilla} <- PlanillasConsulta.borrar_planilla(%Planillas{id: String.to_integer id_planilla}) do
         {:success, PlanillaView, "show.json", planilla: planilla}
    end
  end

end
