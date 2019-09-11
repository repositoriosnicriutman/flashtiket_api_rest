defmodule FlashtiketWeb.Plugs.Administrador do
  import Plug.Conn
  def init(default), do: default
  def call(conn, _default) do
    IO.inspect conn.assigns.signed_user.rol
    with "admin" <- conn.assigns.signed_user.rol do
      conn
    else
      _ ->
        unauthorized(conn)
    end

  end

  defp unauthorized(conn) do
    conn |> send_resp(401, "Unauthorized") |> halt()
  end
end
