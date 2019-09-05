defmodule FlashtiketWeb.SessionControllerTest do
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

  setup do
    conn = post(build_conn(), "/api/crear_usuario", @usuario)
    {:ok, conn: conn}
  end

  test "iniciar session", %{conn: conn} do
    auth = post(build_conn(), "/sessions/sign_in", %{"email" => "nicriutman@gmail.com", "password" => "315"})
    assert json_response(auth, 200) == true
  end

end
