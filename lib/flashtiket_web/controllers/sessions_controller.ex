defmodule FlashtiketWeb.SessionsController do
  use FlashtiketWeb, :controller
  alias Flashtiket.SessionsConsulta

  def create(conn, %{"email" => email, "password" => password}) do
    case SessionsConsulta.sign_in(email, password) do
      {:ok, auth_token} ->
        conn
        |> put_status(:ok)
        |> render("show.json", auth_token)
      {:error, reason} ->
        conn
        |> send_resp(401, reason)
    end
  end

  def delete(conn, _) do
    case SessionsConsulta.sign_out(conn) do
      {:error, reason} -> conn |> send_resp(400, reason)
      {:ok, _} -> conn |> send_resp(204, "")
    end
  end

end
