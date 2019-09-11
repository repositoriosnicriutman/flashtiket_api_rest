defmodule FlashtiketWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate
  alias Flashtiket.UsuariosConsulta
  alias Flashtiket.SessionsConsulta

  @usuario %{
      "nombre" => "brandon castro",
      "cc" => "1069748842",
      "celular" => "3153356923",
      "email" => "nicriutman@gmail.com",
      "password" => "315",
      "rol" => "admin"
    }


  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest
      alias FlashtiketWeb.Router.Helpers, as: Routes

      # The default endpoint for testing
      @endpoint FlashtiketWeb.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Flashtiket.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Flashtiket.Repo, {:shared, self()})
    end

    {:ok, usuario} = UsuariosConsulta.crear_usuario(@usuario)
    {:ok, autorizacion} = SessionsConsulta.sign_in("nicriutman@gmail.com", "315")
    conn =
          Phoenix.ConnTest.build_conn()
          |> Plug.Conn.put_req_header("accept", "application/json")
          |> Plug.Conn.put_req_header("authorization", "Bearer #{autorizacion.token}")
    {:ok, conn: conn, usuario: usuario}
  end
end
