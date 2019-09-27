defmodule Flashtiket.Email do
  import Bamboo.Email
  import Bamboo.Phoenix

  def welcome_email do
    base_email() # Build your default email then customize for welcome
    |> to("bscastro@resuelvetudeuda.com")
    |> subject("Welcome!!!")
    |> put_header("Reply-To", "nicriutmanplay@gmail.com")
    |> html_body("<strong>Welcome</strong>")
    |> text_body("Welcome")
  end

  defp base_email do
    new_email()
    |> from("nicriutmanplay@gmail.com") # Set a default from
    |> put_html_layout({MyApp.LayoutView, "email.html"}) # Set default layout
    |> put_text_layout({MyApp.LayoutView, "email.text"}) # Set default text layout
  end
end
