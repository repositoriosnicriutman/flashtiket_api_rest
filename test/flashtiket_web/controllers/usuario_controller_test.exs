defmodule FlashtiketWeb.UsuarioControllerTest do
  use FlashtiketWeb.ConnCase
  alias Flashtiket.Usuarios
  alias Flashtiket.UsuariosConsulta

  @usuario %{
    "usuario" => %{
      "nombre" => "brandon",
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

  setup do
    conn = post(build_conn(), "/api/crear_usuario", @usuario)
    {:ok, conn: conn}
  end

  test "crear usuario", %{conn: conn} do
    assert json_response(conn, 200)["status"] == "success"
  end

  test "error crear usuario" do
    conn = post(build_conn(), "/api/crear_usuario", @usuario_error)
    assert json_response(conn, 400)["status"] == "error"
  end

  test "obtener usuario cc", %{conn: conn}do
    conn = get(build_conn(), "/api/obtener_usuarios_cc/#{conn.assigns.usuario.cc}")
    assert json_response(conn, 200)["status"] == "success"
  end

  test "obtener usuarios", %{conn: conn}do
    auth = post(conn, "/sessions/sign_in", %{"email" => "nicriutman@gmail.com", "password" => "315"})
    conn1 = get(auth, "/api/obtener_usuarios")
    [respuesta | cola] = json_response(conn1, 200)
    assert respuesta["status"] == "success"
  end

  test "actualizar", %{conn: conn} do
    conn = put(build_conn(), "/api/actualizar_usuarios", %{
      "usuario" => %{
        "id" => conn.assigns.usuario.id,
        "nombre" => "stevan",
        "cc" => "1069748842",
        "celular" => "3153356923",
        "email" => "nicriutman@gmail.com",
        "password" => "315"
      }
    })
    assert json_response(conn, 200)["status"] == "success"
  end

  test "borrar usuario", %{conn: conn} do
    conn = delete(build_conn(), "/api/borrar_usuario", %{"id" => conn.assigns.usuario.id})
    assert json_response(conn, 200)["status"] == "success"
  end

end
