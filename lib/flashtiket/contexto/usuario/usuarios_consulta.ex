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
    :password
  ]

  def changeset(usuario = %Usuarios{}, parametros \\ %{}) do
    usuario
    |> cast(parametros, @datos)
    |> validate_required(@datos)
    |> validate_format(:usuario, ~r/^[A-Za-z0-9._-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/)
    |> validate_length(:password, min: 3)
    |> unique_constraint(:usuario)
    |> put_hashed_password
  end

  defp put_hashed_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}}
        ->
          put_change(changeset, :encrypted_password, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
          changeset
    end
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
