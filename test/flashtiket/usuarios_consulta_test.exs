defmodule Flashtiket.UsuariosConsultaTest do
  use Flashtiket.DataCase
  alias Flashtiket.UsuariosConsulta
  alias Flashtiket.Usuarios

  @moduletag :modulo_usuario

  @dato %{
    "nombre" => "brandon castro",
    "cc" => "1069748842",
    "celular" => "3153356923",
    "email" => "nicriutman@gmail.com",
    "password" => "315"
  }

  setup do
    {:ok, usuario} = UsuariosConsulta.crear_usuario(@dato)
    {:ok, usuario: usuario}
  end

  test "changeset" do
    changeset = UsuariosConsulta.changeset(%Usuarios{}, @dato)
    assert changeset.valid?
  end

  test "crear_usuario", %{usuario: usuario} do
    assert usuario.cc == "1069748842"
  end

  test "consultar por id", %{usuario: usuario} do
    assert usuario = UsuariosConsulta.consultar_id(usuario.id)
  end

  test "consultar por email", %{usuario: usuario} do
    assert usuario = UsuariosConsulta.consultar_email(usuario.email)
  end

  test "consultar por cc", %{usuario: usuario} do
    assert usuario = UsuariosConsulta.consultar_cc(usuario.cc)
  end

  test "consultar todos" do
    assert usuario = UsuariosConsulta.consultar_todos()
  end

  test "actualizar_usuario", %{usuario: usuario} do
    assert {:ok, struct} = UsuariosConsulta.actualizar_usuario(
      %{"nombre" => "brandon castro",
        "cc" => "1069748842",
        "celular" => "3153356923",
        "email" => "nicriutman@gmail.com",
        "password" => "315335",
        "id" => usuario.id})
  end

  test "borrar usuario", %{usuario: usuario} do
    assert {:ok, struct} = UsuariosConsulta.borrar_usuario(%Usuarios{id: usuario.id})
  end

end
