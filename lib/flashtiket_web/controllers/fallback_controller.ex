defmodule FlashtiketWeb.FallbackControler do
  alias FlashtiketWeb.ErrorView
  use FlashtiketWeb, :controller

  def call(conn, {:success, module, view, assigns}) do
    conn
    |> put_status(200)
    |> render(module, view, assigns)
  end

  def call(conn, {:error, "400.json"}) do
    conn
    |> put_status(400)
    |> render(ErrorView, :"400")
  end

  def call(conn, {:error, "500.json"}) do
    conn
    |> put_status(500)
    |> render(ErrorView, :"500")
  end

  def call(conn, {:error, "404.json"}) do
    conn
    |> put_status(404)
    |> render(ErrorView, :"404")
  end

end
