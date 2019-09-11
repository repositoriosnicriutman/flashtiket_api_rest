defmodule FlashtiketWeb.Plugs.Administrador do
  import Plug.Conn
  def init(default), do: default
  def call(conn, _default) do
    IO.inspect conn.assigns.signed_user.email
    with "admin@gmail.com" <- conn.assigns.signed_user.email do
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
