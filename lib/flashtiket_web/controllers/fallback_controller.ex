defmodule FlashtiketWeb.FallbackControler do
  alias FlashtiketWeb.ErrorView
  alias FlashtiketWeb.ChangesetView
  use FlashtiketWeb, :controller

  def call(conn, {:success, module, view, assigns}) do
    conn
    |> put_status(200)
    |> render(module, view, assigns)
  end

  def call(conn, {:error, "400.json"}) do
    conn
    |> put_status(400)
    |> render(ErrorView, "400.json")
  end

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(400)
    |> render(ChangesetView, "error.json", changeset: changeset)
  end

  def call(conn, {:error, message}) when is_binary(message) do
    conn
    |> put_status(400)
    |> render(ErrorView, "error.json", %{message: message})
  end

  def call(conn, {:error, "500.json"}) do
    conn
    |> put_status(500)
    |> render(ErrorView, "500.json")
  end

  def call(conn, {:error, "404.json"}) do
    conn
    |> put_status(404)
    |> render(ErrorView, "404.json")
  end

end
