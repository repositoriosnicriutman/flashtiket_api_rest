defmodule FlashtiketWeb.UsuarioController do
  use FlashtiketWeb, :controller
  alias Flashtiket.UsuariosConsulta
  alias FlashtiketWeb.UsuarioView
  @moduledoc """
  crear, obtiene, actualiza, y elimina a los usuarios devolviendo un json
  """

  action_fallback(FlashtiketWeb.FallbackControler)

  @doc """
    crear un usuario y devuelve los datos en un json
  """
  @spec crear(map, map) :: tuple
  def crear(_conn, %{"usuario" => datos_usuario}) do
    with {:ok, usuario} <- UsuariosConsulta.crear_usuario(datos_usuario) do
            {:success, UsuarioView, "show.json", usuario: usuario}
    end
  end

  @doc """
    busca todos usuario asociados a un numero de cedula y devuelve los datos en un json
  """
  @spec obtener(map, map) :: tuple
  def obtener(_conn, %{"cc" => cc_usuario}) do
    with usuario <- UsuariosConsulta.consultar_cc(cc_usuario) do
      {:success, UsuarioView, "show_coleccion.json", usuario: usuario}
    end
  end

  @doc """
    busca todos los usuarios y devuelve los datos en un json
  """
  @spec obtener_todos(map, map) :: tuple
  def obtener_todos(_conn, _params) do
    with usuario <- UsuariosConsulta.consultar_todos() do
      {:success, UsuarioView, "show_coleccion.json", usuario: usuario}
    end
  end

  @doc """
    busca un usuario por el email y devuelce los datos en un json
  """
  @spec obtener_email(map, map) :: tuple
  def obtener_email(_conn, %{"email" => email}) do
    with usuario <- UsuariosConsulta.consultar_email(email) do
      {:success, UsuarioView, "show.json", usuario: usuario}
    end
  end

  @doc """
    actualiza un usuario y devuelce los datos en un json
  """
  @spec actualizar(map, map) :: tuple
  def actualizar(_conn, %{"usuario" => datos_usuario}) do
    with {:ok, usuario} <- UsuariosConsulta.actualizar_usuario(datos_usuario) do
            {:success, UsuarioView, "show.json", usuario: usuario}
    end
  end

  @doc """
    borra un usuario
  """
  @spec borrar(map, map) :: tuple
  def borrar(_conn, %{"id" => id_usuario}) do
    with  {:ok, usuario} <- UsuariosConsulta.borrar_usuario(String.to_integer id_usuario) do
            {:success, UsuarioView, "show.json", usuario: usuario}
    end
  end

end
