defmodule Flashtiket.ReservasConsultaTest do
  use Flashtiket.DataCase
  alias Flashtiket.ReservasConsulta
  alias Flashtiket.Reservas
  @moduletag :modulo_reserva

  @dato %{
    "cc" => "1069748842",
    "id_planilla" => "1",
    "puesto" => "1",
  }

  @actualizar_dato %{
    "descripcion" => "debe todo",
    "estado" => "reservado"
  }

  setup do
    {:ok, reservas} = ReservasConsulta.crear_reserva(@dato)
    {:ok, reservas: reservas}
  end

  test "changeset" do
    changeset = ReservasConsulta.changeset(%Reservas{}, @dato)
    assert changeset.valid?
  end

  test "actualizar changeset" do
    changeset = ReservasConsulta.actualizar_changeset(%Reservas{}, @actualizar_dato)
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

  test "consultar id y puesto", %{reservas: reservas} do
    assert reservas = ReservasConsulta.consultar_id_y_puesto(reservas.id_planilla, reservas.puesto)
  end

  test "actualizar_reserva", %{reservas: reservas} do
    assert {:ok, struct} = ReservasConsulta.actualizar_reserva(%{
      "id" => reservas.id,
      "descripcion" => "debe 500",
      "estado" => "confirmado"
    })
  end

  test "borrar reserva", %{reservas: reservas} do
    assert {:ok, struct} = ReservasConsulta.borrar_reserva(reservas.id)
  end

end
