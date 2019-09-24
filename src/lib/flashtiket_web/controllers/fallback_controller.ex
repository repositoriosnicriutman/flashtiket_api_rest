defmodule FlashtiketWeb.FallbackControler do
  alias FlashtiketWeb.ErrorView
  alias FlashtiketWeb.ChangesetView
  use FlashtiketWeb, :controller

  def call(conn, {:success, module, view, assigns}) do
    conn
    |> put_status(200)
    |> render(module, view, assigns)
  end

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(400)
    |> render(ChangesetView, "error.json", changeset: changeset)
  end

  def call(conn, nil) do
    conn
    |> put_status(404)
    |> render(ErrorView, "404.json")
  end

end
