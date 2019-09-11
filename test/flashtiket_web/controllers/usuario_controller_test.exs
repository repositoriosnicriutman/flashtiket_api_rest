defmodule FlashtiketWeb.UsuarioControllerTest do
  use FlashtiketWeb.ConnCase
  alias Flashtiket.SessionsConsulta
  @moduletag :controlador_usuario

  @usuario_error %{
    "usuario" => %{
      "nombre" => "brandon",
      "cc" => "1069748842",
      "celular" => "3153356923",
      "email" => "nicriutman@gmail.com"
    }
  }

  test "crear usuario", %{usuario: usuario} do
    assert usuario.cc == "1069748842"
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
        "id" => usuario.id,
        "nombre" => "stevan",
        "cc" => "1069748842",
        "celular" => "3153356923",
        "email" => "nicriutman@gmail.com",
        "password" => "315",
        "rol" => "admin"
      }
    })
    assert json_response(conn, 200)["status"] == "success"
  end

  #test "borrar usuario", %{conn: conn, id: id} do
   # conn = delete(conn, "/api/borrar_usuario/#{id}")
    #assert json_response(conn, 200)["status"] == "success"
  #end

end
