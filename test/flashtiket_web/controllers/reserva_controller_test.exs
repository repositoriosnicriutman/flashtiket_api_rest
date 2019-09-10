defmodule FlashtiketWeb.ReservaControllerTest do
  use FlashtiketWeb.ConnCase
  alias Flashtiket.SessionsConsulta
  @moduletag :controlador_reserva



  @reserva %{
    "reserva" => %{
      "cc" => "1069748842",
      "id_planilla" => "1",
      "puesto" => "1"
    }
  }

  @reserva_error %{
    "reserva" => %{
      "cc" => "1069748842",
      "id_planilla" => "1"
    }
  }

  @usuario %{
    "usuario" => %{
      "nombre" => "brandon castro",
      "cc" => "1069748842",
      "celular" => "3153356923",
      "email" => "nicriutman@gmail.com",
      "password" => "315"
    }
  }

  setup %{conn: conn} do
    post(conn, "/api/crear_usuario", @usuario)
    {:ok, autorizacion} = SessionsConsulta.sign_in("nicriutman@gmail.com", "315")
    conn =
          Phoenix.ConnTest.build_conn()
          |> Plug.Conn.put_req_header("accept", "application/json")
          |> Plug.Conn.put_req_header("authorization", "Bearer #{autorizacion.token}")
    datos = post(conn, "/api/crear_reserva", @reserva)
    {:ok, conn: conn, datos: datos}
  end

  test "crear reserva", %{datos: datos} do
    assert json_response(datos, 200)["status"] == "success"
  end

  test "error crear reserva", %{conn: conn} do
    conn = post(conn, "/api/crear_reserva", @reserva_error)
    assert json_response(conn, 400)["status"] == "error"
  end

  test "obtener reserva cc", %{conn: conn, datos: datos}do
    conn = get(conn, "/api/obtener_reserva_cc/#{datos.assigns.reserva.cc}")
    [respuesta| _lista] = json_response(conn, 200)
    assert respuesta["status"] == "success"  end

  test "obtener reserva id", %{conn: conn, datos: datos}do
    conn = get(conn, "/api/obtener_reserva_id_planilla/#{datos.assigns.reserva.id_planilla}")
    [respuesta| _lista] = json_response(conn, 200)
    assert respuesta["status"] == "success"
  end

  test "actualizar", %{conn: conn, datos: datos} do
    conn = put(conn, "/api/actualizar_reserva", %{
      "reserva" => %{
        "id" => datos.assigns.reserva.id,
        "descripcion" => "debe 500",
        "estado" => "confirmado"
      }
    })
    assert json_response(conn, 200)["status"] == "success"
  end

  test "borrar reserva", %{conn: conn, datos: datos} do
    conn = delete(conn, "/api/borrar_reserva/#{datos.assigns.reserva.id}")
    assert json_response(conn, 200)["status"] == "success"
  end

end
