defmodule Flashtiket.ReservasConsultaTest do
  use Flashtiket.DataCase
  alias Flashtiket.ReservasConsulta
  alias Flashtiket.Reservas

  @dato %{
    "cc": "1069748842",
    "id_planilla": "1",
    "puesto": "1",
    "descripcion": "debe todo",
    "estado": "reservado"
  }

  setup do
    changeset = ReservasConsulta.changeset(%Reservas{}, @dato)
    reservas = Flashtiket.Repo.insert!(changeset)
    {:ok, reservas: reservas}
  end

  test "changeset" do
    changeset = ReservasConsulta.changeset(%Reservas{}, @dato)
    assert changeset.valid?
  end

  test "crear_reserva", %{reservas: reservas} do
    assert reservas.cc == "1069748842"
  end

  test "consultar cc", %{reservas: reservas} do
    assert reservas = ReservasConsulta.consultar_cc(reservas.cc)
  end

  test "consultar id", %{reservas: reservas} do
    assert reservas = ReservasConsulta.consultar_id(reservas.id_planilla)
  end

  test "actualizar_reserva", %{reservas: reservas} do
    changeset = ReservasConsulta.changeset(%Reservas{id: reservas.id}, %{
      "cc": "1069748842",
      "id_planilla": "1",
      "puesto": "1",
      "descripcion": "debe 500",
      "estado": "confirmado"
    })
    assert {:ok, struct} = ReservasConsulta.actualizar_reserva(changeset)
  end

  test "borrar reserva", %{reservas: reservas} do
    assert {:ok, struct} = ReservasConsulta.borrar_reserva(%Reservas{id: reservas.id})
  end

end
