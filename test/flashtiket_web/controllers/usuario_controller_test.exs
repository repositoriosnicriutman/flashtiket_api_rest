defmodule FlashtiketWeb.UsuarioControllerTest do
  use FlashtiketWeb.ConnCase
  alias Flashtiket.SessionsConsulta
  @moduletag :controlador_usuario

  @usuario %{
    "usuario" => %{
      "nombre" => "brandon castro",
      "cc" => "1069748842",
      "celular" => "3153356923",
      "email" => "nicriutman@gmail.com",
      "password" => "315"
    }
  }

  @usuario_error %{
    "usuario" => %{
      "nombre" => "brandon",
      "cc" => "1069748842",
      "celular" => "3153356923",
      "email" => "nicriutman@gmail.com"
    }
  }

  setup %{conn: conn} do
    usuario = post(conn, "/api/crear_usuario", @usuario)
    {:ok, autorizacion} = SessionsConsulta.sign_in("nicriutman@gmail.com", "315")
    conn =
          Phoenix.ConnTest.build_conn()
          |> Plug.Conn.put_req_header("accept", "application/json")
          |> Plug.Conn.put_req_header("authorization", "Bearer #{autorizacion.token}")
    {:ok, conn: conn, usuario: usuario}
  end

  test "crear usuario", %{usuario: usuario} do
    assert json_response(usuario, 200)["status"] == "success"
  end

  test "error crear usuario", %{conn: conn} do
    usuario = post(conn, "/api/crear_usuario", @usuario_error)
    assert json_response(usuario, 400)["status"] == "error"
  end

  test "obtener usuario cc", %{conn: conn}do
    conn = get(conn, "/api/obtener_usuarios_cc/1069748842")
    [respuesta| _lista] = json_response(conn, 200)
    assert respuesta["status"] == "success"
  end

  test "obtener usuario email", %{conn: conn}do
    conn = get(conn, "/api/obtener_usuarios_email/nicriutman@gmail.com")
    assert json_response(conn, 200)["status"] == "success"
  end

  test "obtener usuarios", %{conn: conn}do
    conn = get(conn, "/api/obtener_usuarios")
    [respuesta| _lista] = json_response(conn, 200)
    assert respuesta["status"] == "success"
  end

  test "actualizar", %{conn: conn, usuario: usuario} do
    conn = put(conn, "/api/actualizar_usuarios", %{
      "usuario" => %{
        "id" => usuario.assigns.usuario.id,
        "nombre" => "stevan",
        "cc" => "1069748842",
        "celular" => "3153356923",
        "email" => "nicriutman@gmail.com",
        "password" => "315"
      }
    })
    IO.inspect conn
    assert json_response(conn, 200)["status"] == "success"
  end

  #test "borrar usuario", %{conn: conn, id: id} do
   # conn = delete(conn, "/api/borrar_usuario/#{id}")
    #assert json_response(conn, 200)["status"] == "success"
  #end

end
