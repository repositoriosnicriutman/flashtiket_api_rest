defmodule FlashtiketWeb.ReservaController do
  use FlashtiketWeb, :controller
  alias Flashtiket.ReservasConsulta
  alias FlashtiketWeb.ReservaView

  action_fallback(FlashtiketWeb.FallbackControler)

  def crear(_conn, %{"reserva" => datos_reserva}) do
    with {:ok, reserva} <- ReservasConsulta.crear_reserva(datos_reserva) do
            {:success, ReservaView, "show.json", reserva: reserva}
    end
  end

  def obtener_cc(_conn, %{"cc" => cc_reserva}) do
    with reserva <- ReservasConsulta.consultar_cc(cc_reserva) do
      {:success, ReservaView, "show_colecction.json", reserva: reserva}
    end
  end

  def obtener_id(_conn, %{"id_planilla" => id_planilla}) do
    with reserva <- ReservasConsulta.consultar_id(id_planilla) do
      {:success, ReservaView, "show_colecction.json", reserva: reserva}
    end
  end

  def obtener_id_planilla_y_puesto(_conn, %{"id_planilla" => id_planilla, "puesto" => puesto}) do
    with reserva <- ReservasConsulta.consultar_id_y_puesto(id_planilla, puesto) do
      {:success, ReservaView, "show.json", reserva: reserva}
    end
  end


  def actualizar(_conn, %{"reserva" => datos_reserva}) do
    with {:ok, reserva} <- Flashtiket.ReservasConsulta.actualizar_reserva(datos_reserva) do
        {:success, ReservaView, "show.json", reserva: reserva}
    end
  end

  def borrar(_conn, %{"id" => id_reserva}) do
    with {:ok, reserva} <- ReservasConsulta.borrar_reserva(String.to_integer id_reserva) do
         {:success, ReservaView, "show.json", reserva: reserva}
    end
  end

end
