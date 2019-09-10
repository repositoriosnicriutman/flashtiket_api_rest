defmodule Flashtiket.SessionsConsulta do
  alias Flashtiket.Services.Authenticator
  alias Flashtiket.Repo
  alias Flashtiket.Usuarios

  def sign_in(email, password) do
    case Comeonin.Bcrypt.check_pass(Repo.get_by(Usuarios, email: email), password) do
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
end
