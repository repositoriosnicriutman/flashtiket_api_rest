defmodule FlashtiketWeb.PlanillaView do
  use FlashtiketWeb, :view
  alias FlashtiketWeb.PlanillaView

  def render("show.json", %{planilla: planilla}) do
    render_one(planilla, PlanillaView, "planilla.json")
  end

  def render("show_coleccion.json", %{planilla: planilla}) do
    render_many(planilla, PlanillaView, "planilla.json")
  end

  def render("planilla.json", %{planilla: planilla}) do
    %{
      status: "success",
      planilla: %{
      id: planilla.id,
      fecha: planilla.fecha,
      hora: planilla.hora,
      codigo: planilla.codigo,
      conductor: planilla.conductor,
      vehiculo: planilla.vehiculo,
      estado: planilla.estado
    }
  }
  end
end
