#!/bin/bash
# USAGE:
# env-prep.sh
#
# NOTE:
# This will copy the .env-example file to .env for use with the docker-compose.

echo -e "Initializing EWC Protocols Handbook Environment"

if [ ! -f "$PWD/.env" ]; then
    # Copy the default .env-example file
    echo -e "No environment for build process"
    echo -e "Copying default environment for build process"
    cp -a "$PWD/.env-example" "$PWD/.env"
fi
