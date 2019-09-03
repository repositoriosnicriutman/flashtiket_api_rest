defmodule FlashtiketWeb.PlanillaControllerTest do
  use FlashtiketWeb.ConnCase
  alias Flashtiket.Planillas
  alias Flashtiket.PlanillasConsulta

  @planilla %{
    "planilla" => %{
      "fecha" => "26-08-2019",
      "hora" => "2:00pm",
      "codigo" => "1",
      "conductor" => "alvaro",
      "vehiculo" => "2344",
      "estado" => "activo"
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


  setup do
    conn = post(build_conn(), "/api/crear_planilla", @planilla)
    {:ok, conn: conn}
  end

  test "crear planilla", %{conn: conn} do
    assert json_response(conn, 200)["status"] == "success"
  end

  test "error crear planilla" do
    conn = post(build_conn(), "/api/crear_planilla", @planilla_error)
    assert json_response(conn, 400)["status"] == "error"
  end

  test "obtener planilla id", %{conn: conn} do
    conn = get(build_conn(), "/api/obtener_planilla_id/#{conn.assigns.planilla.id}")
    assert json_response(conn, 200)["status"] == "success"
  end

  test "obtener planilla fecha", %{conn: conn} do
    conn = get(build_conn(), "/api/obtener_planilla_fecha/#{conn.assigns.planilla.fecha}")
    [respuesta|lista] = json_response(conn, 200)
    assert respuesta["status"] == "success"  end

  test "obtener planilla fecha y hora", %{conn: conn} do
    conn = get(build_conn(), "/api/obtener_planilla_fecha_y_hora/#{conn.assigns.planilla.fecha}/#{conn.assigns.planilla.hora}")
    [respuesta|lista] = json_response(conn, 200)
    assert respuesta["status"] == "success"  end

  test "obtener planilla estado" do
    conn = get(build_conn(), "/api/obtener_planilla_activa")
    [respuesta|lista] = json_response(conn, 200)
    assert respuesta["status"] == "success"  end

  test "actualizar", %{conn: conn} do
    conn = put(build_conn(), "/api/actualizar_planilla", %{
      "planilla" => %{
        "id" => conn.assigns.planilla.id,
        "fecha" => "26/08/2019",
        "hora" => "2:00pm",
        "codigo" => "1",
        "conductor" => "rodrigo",
        "vehiculo" => "2344",
        "estado" => "activo"
      }
    })
    assert json_response(conn, 200)["status"] == "success"
  end

  test "borrar planilla", %{conn: conn} do
    conn = delete(build_conn(), "/api/borrar_planilla", %{"id" => conn.assigns.planilla.id})
    assert json_response(conn, 200)["status"] == "success"
  end
end
