
# 🚀 Puesta en marcha del proyecto con Docker

Este proyecto utiliza **Docker** para facilitar la configuración y despliegue del entorno de desarrollo. Sigue los pasos a continuación para levantar el proyecto en cuestión de minutos.

---

## 🐳 Requisitos previos

Asegúrate de tener Docker instalado en tu sistema. Puedes descargarlo desde el siguiente enlace:

🔗 [Descargar Docker](https://www.docker.com/)
        ó
🔗 [Descargar Docker Desktop](https://www.docker.com/products/docker-desktop/)

---

## ⚙️ Instrucciones de uso

1. Abre una terminal en la carpeta del proyecto (donde se encuentra este archivo `docker-compose.yml`).
2. Ejecuta el siguiente comando para construir y levantar los contenedores en segundo plano:

```bash
docker-compose up -d --build
```

> 🐧 **Nota para usuarios de Linux**: Si el comando anterior no funciona debido a problemas con BuildKit, intenta lo siguiente:

```bash
sudo -E env "DOCKER_BUILDKIT=1" "COMPOSE_DOCKER_CLI_BUILD=1" docker-compose up -d --build
```

Este comando:

- 🔧 Construye las imágenes necesarias
- 🚀 Levanta los servicios definidos en `docker-compose.yml`
- 📦 Ejecuta todo en segundo plano (`-d`)

---

## ✅ Verificar que todo está funcionando

Para asegurarte de que los contenedores están corriendo correctamente, puedes ejecutar:

```bash
docker ps
```

Esto mostrará una lista de los contenedores activos.

> ⏱️ **Nota**: Pasado un tiempo tras levantar los contenedores, la aplicación estará disponible en tu navegador en la siguiente dirección:

```
http://localhost:8080/acme/main
```

---

## 🛑 Cómo detener los contenedores

Para detener los contenedores que se levantaron con `docker-compose`, ejecuta:

```bash
docker-compose down
```

Esto:

- 🔻 Detiene los contenedores
- 🧼 Elimina la red creada por `docker-compose` (pero **no** elimina las imágenes)

---

## 🧹 Limpieza completa (opcional)

Si deseas eliminar también las imágenes generadas por Docker para liberar espacio, puedes ejecutar:

```bash
docker-compose down --rmi all
```

Este comando:

- 🗑️ Elimina los contenedores
- 🧼 Borra todas las imágenes asociadas

---

## 📎 Recursos útiles

- [Documentación oficial de Docker Compose](https://docs.docker.com/compose/)
- [Comandos básicos de Docker](https://docs.docker.com/engine/reference/commandline/docker/)

---

¡Y listo! Tu entorno ya debería estar funcionando correctamente dentro de Docker. 🙌
