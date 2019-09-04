defmodule FlashtiketWeb.SessionsController do
  use FlashtiketWeb, :controller
  alias Flashtiket.UsuariosConsulta

  def create(conn, %{"email" => email, "password" => password}) do
    IO.puts "hola1"
    case UsuariosConsulta.sign_in(email, password) do
      {:ok, auth_token} ->
        IO.puts "hola2"
        conn
        |> put_status(:ok)
        |> render("show.json", auth_token)
      {:error, reason} ->
        conn
        |> send_resp(401, reason)
    end
  end
def delete(conn, _) do
    case UsuariosConsulta.sign_out(conn) do
      {:error, reason} -> conn |> send_resp(400, reason)
      {:ok, _} -> conn |> send_resp(204, "")
    end
  end
end