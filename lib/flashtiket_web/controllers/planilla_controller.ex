defmodule FlashtiketWeb.PlanillaController do
  use FlashtiketWeb, :controller
  alias Flashtiket.PlanillasConsulta
  alias Flashtiket.Planillas
  alias FlashtiketWeb.PlanillaView

  action_fallback(FlashtiketWeb.FallbackControler)


  def crear(_conn, %{"planilla" => datos_planilla}) do
    changeset = PlanillasConsulta.changeset(%Planillas{}, datos_planilla)
    case changeset.valid? do
      true->
        {:ok, planilla} = PlanillasConsulta.crear_planilla(changeset)
        {:success, PlanillaView, "show.json", %{planilla: planilla}}
      false ->
          {:error, "400.json"}
    end
  end

  def obtener_id(_conn, %{"id" => id_planilla}) do
    case PlanillasConsulta.consultar_id(id_planilla) do
      nil ->
          {:error, "404.json"}
      planilla ->
          {:success, PlanillaView, "show.json", %{planilla: planilla}}
      {:error, reason} ->
          {:error, reason}
    end
  end

  def obtener_fecha(_conn, %{"fecha" => fecha_planilla}) do
    case PlanillasConsulta.consultar_fecha(fecha_planilla) do
      nil ->
          {:error, "404.json"}
      planilla ->
          {:success, PlanillaView, "show_coleccion.json", %{planilla: planilla}}
      {:error, reason} ->
          {:error, reason}
    end
  end

  def obtener_fecha_y_hora(_conn, %{"fecha" => fecha_planilla, "hora" => hora_planilla}) do
    case PlanillasConsulta.consultar_fecha_y_hora(fecha_planilla, hora_planilla) do
      nil ->
          {:error, "404.json"}
      planilla ->
          {:success, PlanillaView, "show_coleccion.json", %{planilla: planilla}}
      {:error, reason} ->
          {:error, reason}
    end
  end

  def obtener_activa(_conn, _params) do
    case PlanillasConsulta.consultar_activa() do
      nil ->
          {:error, "404.json"}
      planilla ->
          {:success, PlanillaView, "show_coleccion.json", %{planilla: planilla}}
      {:error, reason} ->
          {:error, reason}
    end
  end

  def actualizar(_conn,
  %{"planilla" =>  %{
      "fecha" => _cc,
      "hora" => _celular,
      "codigo" => _contraseña,
      "id" => id,
      "conductor" => _nombre,
      "vehiculo" => _usuario,
      "estado" => _estado} = datos_planilla}) do
    changeset = Flashtiket.PlanillasConsulta.changeset(%Planillas{id: id},datos_planilla)
    case changeset.valid? do
      true ->
        {:ok, planilla} = PlanillasConsulta.actualizar_planilla(changeset)
        {:success, PlanillaView, "show.json", %{planilla: planilla}}
      false ->
        {:error, "400.json"}
    end
  end

  def borrar(_conn, %{"id" => id_planilla}) do
    case PlanillasConsulta.borrar_planilla(%Planillas{id: id_planilla}) do
      {:ok, planilla} ->
        {:success, PlanillaView, "show.json", planilla: planilla}
      {:error, razon} ->
        {:error, razon}
    end
  end

end
