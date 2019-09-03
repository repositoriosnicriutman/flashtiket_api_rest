defmodule FlashtiketWeb.UsuarioController do
  use FlashtiketWeb, :controller
  alias Flashtiket.Usuarios
  alias Flashtiket.UsuariosConsulta
  alias FlashtiketWeb.UsuarioView

  action_fallback(FlashtiketWeb.FallbackControler)

  def crear(_conn, %{"usuario" => datos_usuario}) do
    changeset = Flashtiket.UsuariosConsulta.changeset(%Usuarios{},datos_usuario)
    case changeset.valid? do
      true ->
        {:ok, usuario} = UsuariosConsulta.crear_usuario(changeset)
        {:success, UsuarioView, "show.json", usuario: usuario}
      false ->
        {:error, "400.json"}
    end
  end

  def obtener(_conn, %{"cc" => cc_usuario}) do
    case UsuariosConsulta.consultar_cc(cc_usuario) do
      nil ->
          {:error, "404.json"}
      usuario ->
          {:success, UsuarioView, "show.json", usuario: usuario}
      {:error, reason} ->
          {:error, reason}
    end
  end

  def obtener_todos(_conn, _params) do
    case UsuariosConsulta.consultar_todos() do
      nil ->
          {:error, "404.json"}
      usuario ->
          {:success, UsuarioView, "show_coleccion.json", usuario: usuario}
      {:error, reason} ->
          {:error, reason}
    end
  end

  def actualizar(_conn,
  %{"usuario" =>  %{
      "id" => id,
      "cc" => _cc,
      "celular" => _celular,
      "contraseña" => _contraseña,
      "nombre" => _nombre,
      "usuario" => _usuario} = datos_usuario}) do
    changeset = Flashtiket.UsuariosConsulta.changeset(%Usuarios{id: id},datos_usuario)
    case changeset.valid? do
      true ->
        {:ok, usuario} = UsuariosConsulta.actualizar_usuario(changeset)
        {:success, UsuarioView, "show.json", usuario: usuario}
      false ->
        {:error, "400.json"}
    end
  end

  def borrar(_conn, %{"id" => id_usuario}) do
    case UsuariosConsulta.borrar_usuario(%Usuarios{id: id_usuario}) do
      {:ok, usuario} ->
        {:success, UsuarioView, "show.json", usuario: usuario}
      {:error, razon} ->
        {:error, razon}
    end
  end

end
