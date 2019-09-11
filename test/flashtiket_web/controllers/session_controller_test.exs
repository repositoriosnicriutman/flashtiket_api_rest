defmodule FlashtiketWeb.SessionControllerTest do
  use FlashtiketWeb.ConnCase
  @moduletag :controlador_session

  test "iniciar session", %{conn: conn}do
    session = post(conn, "/sessions/sign_in", %{"email" => "nicriutman@gmail.com", "password" => "315"})
    assert session.status == 200
  end

end
