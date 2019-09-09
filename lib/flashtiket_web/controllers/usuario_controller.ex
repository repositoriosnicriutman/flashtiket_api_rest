defmodule FlashtiketWeb.UsuarioController do
  use FlashtiketWeb, :controller
  alias Flashtiket.Usuarios
  alias Flashtiket.UsuariosConsulta
  alias FlashtiketWeb.UsuarioView

  action_fallback(FlashtiketWeb.FallbackControler)

  def crear(_conn, %{"usuario" => datos_usuario}) do
    with {:ok, usuario} <- UsuariosConsulta.crear_usuario(datos_usuario) do
            {:success, UsuarioView, "show.json", usuario: usuario}
    end
  end

  def obtener(_conn, %{"cc" => cc_usuario}) do
    with usuario <- UsuariosConsulta.consultar_cc(cc_usuario) do
      {:success, UsuarioView, "show_coleccion.json", usuario: usuario}
    end
  end

  def obtener_todos(_conn, _params) do
    with usuario <- UsuariosConsulta.consultar_todos() do
      {:success, UsuarioView, "show_coleccion.json", usuario: usuario}
    end
  end

  def obtener_email(_conn, %{"email" => email}) do
    with usuario <- UsuariosConsulta.consultar_email(email) do
      {:success, UsuarioView, "show.json", usuario: usuario}
    end
  end

  def actualizar(_conn, %{"usuario" => datos_usuario}) do
    with {:ok, usuario} <- UsuariosConsulta.actualizar_usuario(datos_usuario) do
            {:success, UsuarioView, "show.json", usuario: usuario}
    end
  end

  def borrar(_conn, %{"id" => id_usuario}) do
    with  {:ok, usuario} <- UsuariosConsulta.borrar_usuario(%Usuarios{id: String.to_integer id_usuario}) do
            {:success, UsuarioView, "show_coleccion.json", usuario: usuario}
    end
  end

end
