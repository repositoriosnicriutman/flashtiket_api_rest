defmodule FlashtiketWeb.ReservaView do
  use FlashtiketWeb, :view

  def render("show.json", %{reserva: reserva}) do
    render_one(reserva, FlashtiketWeb.ReservaView, "consulta.json")
  end

  def render("show_colecction.json", %{reserva: reserva}) do
    render_many(reserva, FlashtiketWeb.ReservaView, "consulta.json")
  end

  def render("consulta.json", %{reserva: reserva}) do
    %{
      status: "success",
      reserva: %{
        id: reserva.id,
        cc: reserva.cc,
        id_planilla: reserva.id_planilla,
        puesto: reserva.puesto,
        descripcion: reserva.descripcion,
        estado: reserva.estado
      }
    }
  end

end
