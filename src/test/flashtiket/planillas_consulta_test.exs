defmodule Flashtiket.PlanillasConsultaTest do
  use Flashtiket.DataCase
  alias Flashtiket.PlanillasConsulta
  alias Flashtiket.Planillas
  @moduletag :modulo_planilla

  @dato %{
    "fecha" => "26/08/2019",
    "hora" => "2:00pm",
    "codigo" => "1"
  }

  @actualizar %{
      "conductor" => "rodrigo",
      "vehiculo" => "1548",
      "estado" => "activo"
  }

  setup do
    {:ok, planilla} = PlanillasConsulta.crear_planilla(@dato)
    {:ok, planilla: planilla}
  end

  test "changeset" do
    changeset = PlanillasConsulta.changeset(%Planillas{}, @dato)
    assert changeset.valid?
  end

  test "actualizar changeset" do
    changeset = PlanillasConsulta.actualizar_changeset(%Planillas{}, @actualizar)
    assert changeset.valid?
  end

  test "crear_planilla", %{planilla: planilla}do
    assert planilla.fecha == "26/08/2019"
  end

  test "consultar id", %{planilla: planilla} do
    assert %{id: id} = PlanillasConsulta.consultar_id(planilla.id)
  end

  test "consultar fecha", %{planilla: planilla} do
    assert [schema] = PlanillasConsulta.consultar_fecha(planilla.fecha)
  end

  test "consultar fecha y hora", %{planilla: planilla} do
    assert [schema] = PlanillasConsulta.consultar_fecha_y_hora(planilla.fecha, planilla.hora)
  end

  test "consultar fecha, hora y codigo", %{planilla: planilla} do
    assert %{id: id} = PlanillasConsulta.consultar_fecha_hora_y_codigo(planilla.fecha, planilla.hora, planilla.codigo)
  end

  test "consultar activa", %{planilla: planilla} do
    assert [schema] = PlanillasConsulta.consultar_activa()
  end

  test "actualizar_planilla", %{planilla: planilla} do
    assert {:ok, struct} = PlanillasConsulta.actualizar_planilla(%{
      "id" => planilla.id,
      "conductor" => "rodrigo",
      "vehiculo" => "1548",
      "estado" => "activo"
    })
  end

  test "borrar planilla", %{planilla: planilla} do
    assert {:ok, struct} = PlanillasConsulta.borrar_planilla(planilla.id)
  end

end
