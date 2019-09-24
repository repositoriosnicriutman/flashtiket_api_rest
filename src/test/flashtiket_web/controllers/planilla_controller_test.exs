defmodule FlashtiketWeb.PlanillaControllerTest do
  use FlashtiketWeb.ConnCase
  alias Flashtiket.SessionsConsulta
  @moduletag :controlador_planilla


  @planilla %{
    "planilla" => %{
      "fecha" => "26-08-2019",
      "hora" => "2:00pm",
      "codigo" => "1"
    }
  }

  @planilla_error %{
    "planilla" => %{
      "fecha" => "26-08-2019",
      "hora" => "2:00pm",
      "codigo" => "1",
      "conductor" => "alvaro"
    }
  }

  setup %{conn: conn} do
    datos = post(conn, "/api/crear_planilla", @planilla)
    {:ok, conn: conn, datos: datos}
  end

  test "crear planilla", %{datos: datos} do
    assert json_response(datos, 200)["status"] == "success"
  end

  test "error crear planilla", %{conn: conn} do
    conn = post(conn, "/api/crear_planilla", @planilla_error)
    assert json_response(conn, 400)["status"] == "error"
  end

  test "obtener planilla id", %{conn: conn, datos: datos} do
    conn = get(conn, "/api/obtener_planilla_id/#{datos.assigns.planilla.id}")
    assert json_response(conn, 200)["status"] == "success"
  end

  test "obtener planilla fecha", %{conn: conn, datos: datos} do
    conn = get(conn, "/api/obtener_planilla_fecha/#{datos.assigns.planilla.fecha}")
    [respuesta| _lista] = json_response(conn, 200)
    assert respuesta["status"] == "success"  end

  test "obtener planilla fecha y hora", %{conn: conn, datos: datos} do
    conn = get(conn, "/api/obtener_planilla_fecha_y_hora/#{datos.assigns.planilla.fecha}/#{datos.assigns.planilla.hora}")
    [respuesta| _lista] = json_response(conn, 200)
    assert respuesta["status"] == "success"  end

  test "obtener planilla estado", %{conn: conn} do
    conn = get(conn, "/api/obtener_planilla_activa")
    [respuesta| _lista] = json_response(conn, 200)
    assert respuesta["status"] == "success"  end

  test "actualizar", %{conn: conn, datos: datos} do
    conn = put(conn, "/api/actualizar_planilla", %{
      "planilla" => %{
        "id" => datos.assigns.planilla.id,
        "conductor" => "rodrigo",
        "vehiculo" => "2344",
        "estado" => "activo"
      }
    })
    assert json_response(conn, 200)["status"] == "success"
  end

  test "borrar planilla", %{conn: conn, datos: datos} do
    conn = delete(conn, "/api/borrar_planilla/#{datos.assigns.planilla.id}")
    assert json_response(conn, 200)["status"] == "success"
  end
end
