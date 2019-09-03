defmodule FlashtiketWeb.UsuarioView do
  use FlashtiketWeb, :view
  alias FlashtiketWeb.UsuarioView

  def render("show.json", %{usuario: usuario}) do
    render_one(usuario, UsuarioView, "usuario.json")
  end

  def render("show_coleccion.json", %{usuario: usuario}) do
    render_many(usuario, UsuarioView, "usuario.json")
  end

  def render("usuario.json", %{usuario: usuario}) do
    %{
      status: "success",
      usuario: %{
      id: usuario.id,
      nombre: usuario.nombre,
      cc: usuario.cc,
      celular: usuario.celular,
      usuario: usuario.usuario,
      contraseña: usuario.contraseña
    }
  }
  end
end
