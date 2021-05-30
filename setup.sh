#!/bin/bash

PROGDIR=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd )

CONFDIR="${XDG_CONFIG_HOME:-$HOME/.config}/hre-utils/conf"
mkdir -p "$CONFDIR"

DATABASE="${CONFDIR}/database"
touch "$DATABASE"

CONFFILE="${CONFDIR}/config"
cp -vn "${PROGDIR}/doc/share/config" "${CONFFILE}"

sudo ln -sv "${PROGDIR}/doc/share/_conf.sh" "/etc/bash_completion.d/"
