defmodule FlashtiketWeb.Auth.Guardian do
  use Guardian, otp_app: :Flashtiket

  alias Flashtiket.UsuariosConsulta

  def subject_for_token(user, _claims) do
    sub = to_string(user.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    resource = UsuariosConsulta.consultar_id(id)
    {:ok,  resource}
  end
end
