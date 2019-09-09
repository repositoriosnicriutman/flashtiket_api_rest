defmodule Flashtiket.UsuariosConsulta do
  alias Flashtiket.Usuarios
  alias Flashtiket.Services.Authenticator
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

  def sign_in(email, password) do
    case Comeonin.Bcrypt.check_pass(consultar_email(email), password) do
      {:ok, user} ->
        token = Authenticator.generate_token(user)
        Repo.insert(Ecto.build_assoc(user, :auth_tokens, %{token: token}))
        err -> err
    end
  end



  def sign_out(conn) do
    case Authenticator.get_auth_token(conn) do
      {:ok, token} ->
        case Repo.get_by(AuthToken, %{token: token}) do
          nil -> {:error, :not_found}
          auth_token -> Repo.delete(auth_token)
        end
      error -> error
    end
  end

  def crear_usuario(parametros) do
    %Usuarios{}
    |> changeset(parametros)
    |> Repo.insert()
  end

  def consultar_cc(cc) do
    query = from u in Flashtiket.Usuarios,
            where: u.cc == ^cc,
            select: u
    Repo.all(query)
  end

  def consultar_email(email) do
    Repo.get_by(Usuarios, email: email)
  end

  def consultar_id(id) do
    Repo.get!(Usuarios, id)
  end

  def consultar_todos() do
    query = from u in Flashtiket.Usuarios,
            select: u
    Repo.all(query)
  end

  def actualizar_usuario(parametros) do
    %Usuarios{id: parametros["id"]}
    |> changeset(parametros)
    |> Repo.update()
  end

  def borrar_usuario(id) do
    Repo.delete(id)
  end

end
