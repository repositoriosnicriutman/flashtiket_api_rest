defmodule FlashtiketWeb.SessionControllerTest do
  use FlashtiketWeb.ConnCase
  @moduletag :controlador_session

  @usuario %{
    "usuario" => %{
      "nombre" => "brandon",
      "cc" => "1069748842",
      "celular" => "3153356923",
      "email" => "nicriutman@gmail.com",
      "password" => "315"
    }
  }

  setup %{conn: conn}do
    post(conn, "/api/crear_usuario", @usuario)
    {:ok, conn: conn}
  end

  test "iniciar session", %{conn: conn}do
    post(conn, "/sessions/sign_in", %{"email" => "nicriutman@gmail.com", "password" => "315"})
    assert "hola" == "hola"
  end

end
