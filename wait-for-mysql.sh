#!/usr/bin/env bash

set -e

HOST="$1"
PORT="$2"
USER="$3"
PASSWORD="$4"
TIMEOUT="$5"
shift 5  # Elimina los 5 primeros argumentos del array $@

echo "Esperando a que MySQL en $HOST:$PORT esté listo..."

for i in $(seq 1 "$TIMEOUT"); do
  if mysqladmin ping -h"$HOST" -P"$PORT" -u"$USER" -p"$PASSWORD" --silent; then
    echo "MySQL está listo."
    break
  fi
  echo "Esperando... ($i/$TIMEOUT)"
  sleep 1
done

if ! mysqladmin ping -h"$HOST" -P"$PORT" -u"$USER" -p"$PASSWORD" --silent; then
  echo "Tiempo agotado esperando a MySQL"
  exit 1
fi

echo "Ejecutando aplicación..."
exec "$@"
