defmodule FlashtiketWeb.ReservaController do
  use FlashtiketWeb, :controller
  alias Flashtiket.ReservasConsulta
  alias FlashtiketWeb.ReservaView
  @moduledoc """
  crear, obtiene, actualiza, y elimina las reservas devolviendo un json
  """

  action_fallback(FlashtiketWeb.FallbackControler)

  @doc """
    crea una reserva con los campos cc, id_planilla, puesto y devuelve un json con los datos
  """
  @spec crear(map, map) :: tuple
  def crear(_conn, %{"reserva" => datos_reserva}) do
    with {:ok, reserva} <- ReservasConsulta.crear_reserva(datos_reserva) do
            {:success, ReservaView, "show.json", reserva: reserva}
    end
  end

  @doc """
    busca todas las reserva asociadas a una cedula y devuelve un json con los datos
  """
  @spec obtener_cc(map, map) :: tuple
  def obtener_cc(_conn, %{"cc" => cc_reserva}) do
    with reserva <- ReservasConsulta.consultar_cc(cc_reserva) do
      {:success, ReservaView, "show_colecction.json", reserva: reserva}
    end
  end

  @doc """
    busca una reserva por el id_planilla y devuelve un json con los datos
  """
  @spec obtener_id(map, map) :: tuple
  def obtener_id(_conn, %{"id_planilla" => id_planilla}) do
    with reserva <- ReservasConsulta.consultar_id(id_planilla) do
      {:success, ReservaView, "show_colecction.json", reserva: reserva}
    end
  end

  @doc """
    busca una reserva por el id_planilla y puesto, devolviendo un json con los datos
  """
  @spec obtener_id_planilla_y_puesto(map, map) :: tuple
  def obtener_id_planilla_y_puesto(_conn, %{"id_planilla" => id_planilla, "puesto" => puesto}) do
    with reserva <- ReservasConsulta.consultar_id_y_puesto(id_planilla, puesto) do
      {:success, ReservaView, "show.json", reserva: reserva}
    end
  end

  @doc """
    actualiza la descripcion y el estado de una reserva y devuelve un json con los datos
  """
  @spec actualizar(map, map) :: tuple
  def actualizar(_conn, %{"reserva" => datos_reserva}) do
    with {:ok, reserva} <- Flashtiket.ReservasConsulta.actualizar_reserva(datos_reserva) do
        {:success, ReservaView, "show.json", reserva: reserva}
    end
  end

  @doc """
    borra una reserva por id
  """
  @spec borrar(map, map) :: tuple
  def borrar(_conn, %{"id" => id_reserva}) do
    with {:ok, reserva} <- ReservasConsulta.borrar_reserva(String.to_integer id_reserva) do
         {:success, ReservaView, "show.json", reserva: reserva}
    end
  end

end
