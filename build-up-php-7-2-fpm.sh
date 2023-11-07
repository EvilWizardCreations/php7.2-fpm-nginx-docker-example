#!/bin/bash
# USAGE:
# build-up-php-7-2-fpm.sh
#
# NOTE:
# Rebuild the Docker image & compose up.

# source the environment variables
set -o allexport; source "${PWD}/.env"; set +o allexport

# Use the EWC Protocol to build the image of the service & compose up
ewc-docker-build-up.sh "php-7-2-fpm" "${PHP72_FPM_DOCKER_BUILD_DESC:-PHP-FPM ${PHP_VERSION} Web App}"
