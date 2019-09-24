defmodule FlashtiketWeb.Router do
  use FlashtiketWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticate do
    plug FlashtiketWeb.Plugs.Authenticate
  end

  pipeline :administrador do
    plug FlashtiketWeb.Plugs.Administrador
  end

  scope "/sessions", FlashtiketWeb do

    post "/sign_in", SessionsController, :create
    delete "/sign_out", SessionsController, :delete
  end

  scope "/api", FlashtiketWeb do
    pipe_through :api

    post "/crear_usuario", UsuarioController, :crear
  end

  scope "/api", FlashtiketWeb do
    pipe_through [:authenticate, :api]

    put "/actualizar_usuarios", UsuarioController, :actualizar

    get "/obtener_planilla_id/:id", PlanillaController, :obtener_id
    get "/obtener_planilla_fecha/:fecha", PlanillaController, :obtener_fecha
    get "/obtener_planilla_fecha_y_hora/:fecha/:hora", PlanillaController, :obtener_fecha_y_hora
    get "/obtener_planilla_fecha_hora_y_codigo/:fecha/:hora/:codigo", PlanillaController, :obtener_fecha_hora_y_codigo
    get "/obtener_planilla_activa", PlanillaController, :obtener_activa

    post "/crear_reserva", ReservaController, :crear
    get "/obtener_reserva_cc/:cc", ReservaController, :obtener_cc
    get "/obtener_reserva_id_planilla/:id_planilla", ReservaController, :obtener_id
    get "/obtener_reserva_id_planilla_y_puesto/:id_planilla/:puesto", ReservaController, :obtener_id_planilla_y_puesto
  end

  scope "/api", FlashtiketWeb do
    pipe_through [:authenticate, :api, :administrador]

    get "/obtener_usuarios", UsuarioController, :obtener_todos
    get "/obtener_usuarios_cc/:cc", UsuarioController, :obtener
    get "/obtener_usuarios_email/:email", UsuarioController, :obtener_email
    delete "/borrar_usuario/:id", UsuarioController, :borrar

    post "/crear_planilla", PlanillaController, :crear
    put "/actualizar_planilla", PlanillaController, :actualizar
    delete "/borrar_planilla/:id", PlanillaController, :borrar

    put "/actualizar_reserva", ReservaController, :actualizar
    delete "/borrar_reserva/:id", ReservaController, :borrar

  end
end
