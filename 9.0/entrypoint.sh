#!/bin/bash

set -e

# set the postgres database host, port, user and password
: ${HOST:=${DB_PORT_5432_TCP_ADDR:='db'}}
: ${PORT:=${DB_PORT_5432_TCP_PORT:=5432}}
: ${USER:=${DB_ENV_POSTGRES_USER:=${POSTGRES_USER:='postgres'}}}
: ${PASSWORD:=${DB_ENV_POSTGRES_PASSWORD:=$POSTGRES_PASSWORD}}
# pass them as arguments to the odoo process
DB_ARGS=("--db_user" $USER "--db_password" $PASSWORD "--db_host" $HOST "--db_port" $PORT)

case "$1" in
	--)
		shift
		exec openerp-server "${DB_ARGS[@]}" "$@"
		;;
	-*)
		exec openerp-server "${DB_ARGS[@]}" "$@"
		;;
	*)
		exec "$@"
esac

exit 1
