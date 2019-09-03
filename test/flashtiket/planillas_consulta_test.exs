defmodule Flashtiket.PlanillasConsultaTest do
  use Flashtiket.DataCase
  alias Flashtiket.PlanillasConsulta
  alias Flashtiket.Planillas

  @dato %{
    "fecha": "26/08/2019",
    "hora": "2:00pm",
    "codigo": "1",
    "conductor": "alvaro",
    "vehiculo": "1548",
    "estado": "activo"
  }

  @actualizar %{
    "fecha": "26/08/2019",
    "hora": "2:00pm",
    "codigo": "1",
    "conductor": "rodrigo",
    "vehiculo": "1548",
    "estado": "activo"
  }

  setup do
    changeset = PlanillasConsulta.changeset(%Planillas{}, @dato)
    planilla = Flashtiket.Repo.insert!(changeset)
    {:ok, planilla: planilla}
  end

  test "changeset" do
    changeset = PlanillasConsulta.changeset(%Planillas{}, @dato)
    assert changeset.valid?
  end

  test "crear_planilla", %{planilla: planilla}do
    assert planilla.estado == "activo"
  end

  test "consultar id", %{planilla: planilla} do
    assert planilla = PlanillasConsulta.consultar_id(planilla.id)
  end

  test "consultar fecha", %{planilla: planilla} do
    assert planilla = PlanillasConsulta.consultar_fecha(planilla.fecha)
  end

  test "consultar fecha y hora", %{planilla: planilla} do
    assert planilla = PlanillasConsulta.consultar_fecha_y_hora(planilla.fecha, planilla.hora)
  end

  test "consultar activa", %{planilla: planilla} do
    assert planilla = PlanillasConsulta.consultar_activa()
  end

  test "actualizar_planilla", %{planilla: planilla} do
    changeset = PlanillasConsulta.changeset(%Planillas{id: planilla.id}, @actualizar)
    assert {:ok, struct} = PlanillasConsulta.actualizar_planilla(changeset)
  end

  test "borrar planilla", %{planilla: planilla} do
    assert {:ok, struct} = PlanillasConsulta.borrar_planilla(%Planillas{id: planilla.id})
  end

end
