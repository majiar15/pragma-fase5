# reto pragma fase5

## Nota: 
Para acceder a la aplicación, puedes utilizar cualquier usuario disponible en la [FakeStoreAPI](https://fakestoreapi.com/docs#user). A continuación, te proporciono un ejemplo:
``` json
"usuario": "mor_2314",
"contraseña": "83r5^_"
```
Ten en cuenta que las funcionalidades de registro de usuario y recuperación de contraseña no están disponibles, ya que la FakeStoreAPI no ofrece estos endpoints.

## arquitectura

este reto fue realizado utilizando clean architecture, fue realizado utilizando la metodología DDD (domain-diven-desing), esta app utiliza los paquetes store_design_system y api_fake_storage_orm

estructura:
- data
    - datasource -> aqui se guardan todos los datos locales y remotos de la app
- domain
    - models -> en esta capa se tiene los modelos de datos utilizados en la app
    - repositories -> esta es una capa de de abstracción que permite a domain conocer cuales son los métodos del repositorio
    - use_cases -> esta capa contiene lógica de negocios, puede llamar al repository para realizar acciones con los datos
- presentation
    - bloc -> esta capa que se comunica con el dominio y conviene los datos en streams para su consumo en los widgets
    - pages -> en esta capa las vistas de la aplicacion
    - routes -> esta capa contiene la información necesaria para la navegación

## Diagrama de flujo

![diagrama de flujo](./docs/diagrama%20eccomerce.drawio.png)




## Instalación 🔧

### _1. clone el repositorio_

```
git clone https://github.com/majiar15/pragma-fase5
```

### _2. instale los paquetes_

```
flutter pub get
```

### _3. encendemos la aplicacion_

```
flutter run
```
