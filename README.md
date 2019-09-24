bienvenido a flashtiket

esta es una api rest echa en phoenix en la que puede crear, actualizar, buscar y eliminar usuario, planilla y reservas, para la implementacion de un sitio web que le permita hacer reservaciones de pasajes a los usuarios, las planillas que el administrador crea.

requisitos de ejecucion

-docker
-postman

ejecucion

ir a la carpeta raiz, y ejecutar los siguientes comandos
- ./mix deps.get
- ./mix ecto.create
- ./mix ecto.migrate
- docker-compose up

postman

en la raiz hay un archivo json llamado Flashtiket.postman_collection que son las consultas a la api rest

uso de la api

- empiece creando un usuario, admin@gmail.com es el que esta definido para tener acceso a todas las consultas
- inicie session con este correo
- copie el codigo token y peguelo en la autorizacion bearer token de la consulta que vaya a realizar

test

vaya a la carpeta src y escriba el comando mix test


NOTA: la implementacion docker no es mia, pero la api rest si lo es. aun asi estudie la manera en que funciona, porfavor deja tu comentario. 
