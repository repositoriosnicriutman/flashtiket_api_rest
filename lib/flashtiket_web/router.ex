defmodule FlashtiketWeb.Router do
  use FlashtiketWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", FlashtiketWeb do
    pipe_through :api

    post "/crear_usuario", UsuarioController, :crear
    get "/obtener_usuarios_cc/:cc", UsuarioController, :obtener
    get "/obtener_usuarios", UsuarioController, :obtener_todos
    put "/actualizar_usuarios", UsuarioController, :actualizar
    delete "/borrar_usuario", UsuarioController, :borrar

    post "/crear_planilla", PlanillaController, :crear
    get "/obtener_planilla_id/:id", PlanillaController, :obtener_id
    get "/obtener_planilla_fecha/:fecha", PlanillaController, :obtener_fecha
    get "/obtener_planilla_fecha_y_hora/:fecha/:hora", PlanillaController, :obtener_fecha_y_hora
    get "/obtener_planilla_activa", PlanillaController, :obtener_activa
    put "/actualizar_planilla", PlanillaController, :actualizar
    delete "/borrar_planilla", PlanillaController, :borrar

    post "/crear_reserva", ReservaController, :crear
    get "/obtener_reserva_cc/:cc", ReservaController, :obtener_cc
    get "/obtener_reserva_id/:id_planilla", ReservaController, :obtener_id
    put "/actualizar_reserva", ReservaController, :actualizar
    delete "/borrar_reserva", ReservaController, :borrar
  end
end
