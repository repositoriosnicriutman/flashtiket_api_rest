defmodule Flashtiket.UsuariosConsultaTest do
  use Flashtiket.DataCase
  alias Flashtiket.UsuariosConsulta
  alias Flashtiket.Usuarios
  @moduletag :modulo_usuario

  @dato %{
    "nombre" => "brandon castro",
    "cc" => "1069748842",
    "celular" => "3153356923",
    "email" => "admin@gmail.com",
    "password" => "315"
  }

  setup do
    usuario = UsuariosConsulta.crear_usuario(@dato)
    {:ok, usuario: usuario}
  end

  test "changeset" do
    changeset = UsuariosConsulta.changeset(%Usuarios{}, @dato)
    assert changeset.valid?
  end

  test "crear_usuario", %{usuario: usuario} do
    assert {:ok, usuario} = usuario
  end

  test "consultar por id", %{usuario: {:ok, usuario}} do
    assert %{id: id} = UsuariosConsulta.consultar_id(usuario.id)
  end

  test "consultar por email", %{usuario: {:ok, usuario}} do
    assert %{id: id} = UsuariosConsulta.consultar_email(usuario.email)
  end

  test "consultar por cc", %{usuario: {:ok, usuario}} do
    assert [schema] = UsuariosConsulta.consultar_cc(usuario.cc)
  end

  test "consultar todos" do
    assert [schema] = UsuariosConsulta.consultar_todos()
  end

  test "actualizar_usuario", %{usuario: {:ok, usuario}} do
    assert {:ok, usuario} = UsuariosConsulta.actualizar_usuario(
      %{"nombre" => "brandon castro",
        "cc" => "1069748842",
        "celular" => "3153356923",
        "email" => "admin@gmail.com",
        "password" => "315335",
        "id" => usuario.id})
  end

  test "borrar usuario", %{usuario: {:ok, usuario}} do
    assert {:ok, struct} = UsuariosConsulta.borrar_usuario(usuario.id)
  end

end
