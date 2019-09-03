defmodule FlashtiketWeb.ReservaController do
  use FlashtiketWeb, :controller
  alias Flashtiket.Reservas
  alias Flashtiket.ReservasConsulta
  alias FlashtiketWeb.ReservaView

  action_fallback(FlashtiketWeb.FallbackControler)

  def crear(_conn, %{"reserva" => datos_reserva}) do
    changeset = Flashtiket.ReservasConsulta.changeset(%Reservas{},datos_reserva)
    case changeset.valid? do
      true ->
        {:ok, reserva} = ReservasConsulta.crear_reserva(changeset)
        {:success, ReservaView, "show.json", reserva: reserva}
      false ->
        {:error, "400.json"}
    end
  end

  def obtener_cc(_conn, %{"cc" => cc_reserva}) do
    case ReservasConsulta.consultar_cc(cc_reserva) do
      nil ->
          {:error, "404.json"}
      reserva ->
          {:success, ReservaView, "show_colecction.json", reserva: reserva}
      {:error, reason} ->
          {:error, reason}
    end
  end

  def obtener_id(_conn, %{"id_planilla" => id_planilla}) do
    case ReservasConsulta.consultar_id(id_planilla) do
      nil ->
          {:error, "404.json"}
      reserva ->
        {:success, ReservaView, "show_colecction.json", %{reserva: reserva}}
      {:error, reason} ->
          {:error, reason}
    end
  end


  def actualizar(_conn,
  %{"reserva" =>  %{
      "cc" => _cc,
      "id_planilla" => _id_planilla,
      "puesto" => _puesto,
      "id" => id,
      "descripcion" => _descripcion,
      "estado" => _estado} = datos_reserva}) do
    changeset = Flashtiket.ReservasConsulta.changeset(%Reservas{id: id},datos_reserva)
    case changeset.valid? do
      true ->
        {:ok, reserva} = ReservasConsulta.actualizar_reserva(changeset)
        {:success, ReservaView, "show.json", reserva: reserva}
      false ->
        {:error, "400.json"}
    end
  end

  def borrar(_conn, %{"id" => id_reserva}) do
    case ReservasConsulta.borrar_reserva(%Reservas{id: id_reserva}) do
      {:ok, reserva} ->
        {:success, ReservaView, "show.json", reserva: reserva}
      {:error, razon} ->
        {:error, razon}
    end
  end

end
