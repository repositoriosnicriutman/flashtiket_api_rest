defmodule Flashtiket.UsuariosConsultaTest do
  use Flashtiket.DataCase
  alias Flashtiket.UsuariosConsulta
  alias Flashtiket.Usuarios

  @dato %{
    "nombre": "brandon",
    "cc": "1069748842",
    "celular": "3153356923",
    "usuario": "nicriutman",
    "contraseña": "315"
  }

  @dato2 %{
    "nombre": "brandon",
    "cc": "1069748843",
    "celular": "3195244467",
    "usuario": "nicriutman",
    "contraseña": "315"
  }

  setup do
    changeset = UsuariosConsulta.changeset(%Usuarios{}, @dato)
    usuario = Flashtiket.Repo.insert!(changeset)
    {:ok, usuario: usuario}
  end

  test "changeset" do
    changeset = UsuariosConsulta.changeset(%Usuarios{}, @dato)
    assert changeset.valid?
  end

  test "crear_usuario", %{usuario: usuario} do
    assert usuario.cc == "1069748842"
  end

  test "consultar cc", %{usuario: usuario} do
    assert usuario = UsuariosConsulta.consultar_cc(usuario.cc)
  end

  test "actualizar_usuario", %{usuario: usuario} do
    changeset = UsuariosConsulta.changeset(%Usuarios{id: usuario.id}, %{
      "nombre": "stevan",
      "cc": "1069748842",
      "celular": "3153356923",
      "usuario": "nicriutman",
      "contraseña": "315"
    })
    assert {:ok, struct} = UsuariosConsulta.actualizar_usuario(changeset)
  end

  test "borrar usuario", %{usuario: usuario} do
    assert {:ok, struct} = UsuariosConsulta.borrar_usuario(%Usuarios{id: usuario.id})
  end

  test "consultar todos" do
    assert usuario = UsuariosConsulta.consultar_todos()
  end

end
