defmodule Flashtiket.UsuariosConsulta do
  alias Flashtiket.Usuarios
  alias Flashtiket.Repo
  import Ecto.Changeset
  import Ecto.Query

  @datos [
    :nombre,
    :cc,
    :celular,
    :usuario,
    :contraseña
  ]

  def changeset(usuario = %Usuarios{}, parametros \\ %{}) do
    usuario
    |> cast(parametros, @datos)
    |> validate_required(@datos)
  end

  def crear_usuario(changeset) do
    Repo.insert(changeset)
  end

  def consultar_cc(cc) do
    query = from u in Flashtiket.Usuarios,
            where: u.cc == ^cc,
            select: u
    Repo.one(query)
  end

  def consultar_todos() do
    query = from u in Flashtiket.Usuarios,
            select: u
    Repo.all(query)
  end

  def actualizar_usuario(changeset) do
    Repo.update(changeset)
  end

  def borrar_usuario(changeset) do
    Repo.delete(changeset)
  end

end
