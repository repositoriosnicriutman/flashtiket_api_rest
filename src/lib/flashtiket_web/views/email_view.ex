defmodule FlashtiketWeb.EmailView do
  use FlashtiketWeb, :view

  def render("email.json", %{email: email}) do
    %{
      status: "success",
      email: email.text_body
    }
  end
end
