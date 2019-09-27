defmodule FlashtiketWeb.EmailController do
  use FlashtiketWeb, :controller
  alias Flashtiket.Mailer
  alias Flashtiket.Email

  def send_welcome_email(conn, _params) do
    email = Email.welcome_email()   # Create your email
    |> Mailer.deliver_now() # Send your email
    IO.inspect email
    render(conn, "email.json", email: email)
  end

  def index(conn, _params) do
    {:ok, conn}
  end
end
