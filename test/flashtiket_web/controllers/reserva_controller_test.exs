defmodule FlashtiketWeb.ReservaControllerTest do
  use FlashtiketWeb.ConnCase
  alias Flashtiket.Reservas
  alias Flashtiket.ReservasConsulta

  @reserva %{
    "reserva" => %{
      "cc" => "1069748842",
      "id_planilla" => "1",
      "puesto" => "1",
      "descripcion" => "debe todo",
      "estado" => "reservado"
    }
  }

  @reserva_error %{
    "reserva" => %{
      "cc" => "1069748842",
      "id_planilla" => "1"
    }
  }

  setup do
    conn = post(build_conn(), "/api/crear_reserva", @reserva)
    {:ok, conn: conn}
  end

  test "crear reserva", %{conn: conn} do
    assert json_response(conn, 200)["status"] == "success"
  end

  test "error crear reserva" do
    conn = post(build_conn(), "/api/crear_reserva", @reserva_error)
    assert json_response(conn, 400)["status"] == "error"
  end

  test "obtener reserva cc", %{conn: conn}do
    conn = get(build_conn(), "/api/obtener_reserva_cc/#{conn.assigns.reserva.cc}")
    [respuesta|lista] = json_response(conn, 200)
    assert respuesta["status"] == "success"  end

  test "obtener reserva id", %{conn: conn}do
    conn = get(build_conn(), "/api/obtener_reserva_id/#{conn.assigns.reserva.id_planilla}")
    [respuesta|lista] = json_response(conn, 200)
    assert respuesta["status"] == "success"
  end

  test "actualizar", %{conn: conn} do
    conn = put(build_conn(), "/api/actualizar_reserva", %{
      "reserva" => %{
        "id" => conn.assigns.reserva.id,
        "cc" => "1069748842",
        "id_planilla" => "1",
        "puesto" => "1",
        "descripcion" => "debe 500",
        "estado" => "confirmado"
      }
    })
    assert json_response(conn, 200)["status"] == "success"
  end

  test "borrar reserva", %{conn: conn} do
    conn = delete(build_conn(), "/api/borrar_reserva", %{"id" => conn.assigns.reserva.id})
    assert json_response(conn, 200)["status"] == "success"
  end

end
