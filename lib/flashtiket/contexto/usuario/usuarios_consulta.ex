defmodule Flashtiket.UsuariosConsulta do
  alias Flashtiket.Usuarios
  alias Flashtiket.Repo
  import Ecto.Changeset
  import Ecto.Query

  @datos [
    :nombre,
    :cc,
    :celular,
    :email,
    :password
  ]

  @doc """
    comprueba los campos nombre, cc, celular, email y password para crear un usuario
  """

  def changeset(usuario = %Usuarios{}, parametros \\ %{}) do
    usuario
    |> cast(parametros, @datos)
    |> validate_required(@datos)
    |> unique_constraint(:email)
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

  @doc """
    crear un usuario con los campos nombre, cc, celular, email y password
  """
  def crear_usuario(parametros) do
    %Usuarios{}
    |> changeset(parametros)
    |> Repo.insert()
  end

  @doc """
    busca todos los usuarios asociados con la cc
  """
  def consultar_cc(cc) do
    query = from u in Flashtiket.Usuarios,
            where: u.cc == ^cc,
            select: u
    Repo.all(query)
  end

   @doc """
    busca un usuario asociado con el email
  """
  @spec consultar_email(any) :: any
  def consultar_email(email) do
    Repo.get_by(Usuarios, email: email)
  end

   @doc """
    busca un usuario asociados con la id
  """
  def consultar_id(id) do
    Repo.get!(Usuarios, id)
  end

 @doc """
    busca todos los usuarios
  """
  def consultar_todos() do
    query = from u in Flashtiket.Usuarios,
            select: u
    Repo.all(query)
  end

  @doc """
    actualiza todos los campos de usuario
  """
  def actualizar_usuario(parametros) do
    %Usuarios{id: parametros["id"]}
    |> changeset(parametros)
    |> Repo.update()
  end

  @doc """
    elimina un usuario por el campo id
  """
  def borrar_usuario(id) do
    %Usuarios{id: id}
    |>Repo.delete()
  end

end
