# PHP-FPM 7.2 Dockerfile Example

A base PHP-FPM 7.2 image[^docker_pull_cmd_note] for demonstrating legacy projects available at [EWC Docker Hub](https://hub.docker.com/r/ewc2020/web).

An old version of ***PHP*** that some codebase sites still require to emulate a ***production*** environment to run in.

Other Packages Included:

- Node v14.x
- Composer v1.10.1
- libxml2-dev
- libzip-dev
- libyaml-dev
- zip
- unzip
- git
- nodejs
- default-mysql-client
- vim
- npm i npm@`$NPM_VERSION`[^npm_version_note] -g
- yaml

PHP Extensions:

- gettext 
- mysqli 
- pdo_mysql 
- zip
- yaml

## Build Image

Build the ***Docker Image*** without using ***cached*** versions of previous image build stages.

```bash
sudo docker build \
    -f php-7-2-fpm.Dockerfile \
    --target php-7-2-build \
    --build-arg APP_ENV=local \
    --build-arg NPM_VERSION=7.24.2 \
    --no-cache \
    -t php-7-2-fpm:latest \
    .
```

**N.B.**

- Using `-f php-7-2-fpm.Dockerfile`

    To specify the *filename* to ***build*** otherwise it is expected to be named `Dockerfile`.

- Using `--target php-7-2-build`

    To select the ***build target stage***[^multi_stage_builds_note] from the *Dockerfile*.
    
- Using `--build-arg ARG=value`

    To set build argument values to use.

### Create A Container

This creates a named container and attaches it to the ***host network*** and may cause port conflict if the host machine is already listening on any exposed ports from the ***Docker Image*** being used.

```bash
sudo docker run \
    -d \
    --network host \
    -v "$(pwd)"/public_html:/var/www/html \
    --name php-7-2-fpm \
    php-7-2-fpm
```

**OR**

This creates a named container and attaches it to the ***bridge network*** and allows for ***port forward mapping*** from the ***host*** to the ***Container***.

```bash
sudo docker run \
    -d \
    --network bridge \
    -p 8080:80/tcp \
    -v "$(pwd)"/public_html:/var/www/html \
    --name php-7-2-fpm \
    php-7-2-fpm
```

**N.B.**

- Using `-v "$(pwd)"/public_html:/var/www/html`

    To ***Volume Mount*** the folder `public_html` from the current folder to `/var/www/html` on the ***running*** container. It is where ***Apache*** serves the content from & allows for *realtime* change updates.

- Using `-p 8080:80/tcp` 

    To map port **8080** on the ***Host*** machine to port **80** on the ***Container*** using the ***bridge network***.

- Using `--name php-7-2-fpm`

    To name the ***Container*** being created.

### Start Container

```bash
sudo docker start php-7-2-fpm
```

### Stop Container

```bash
sudo docker stop php-7-2-fpm
```

## Docker Compose

A `docker-compose` configuration file is included to simplify the build & deployment of the image.

### Build - No Cache

This is only necessary when completely rebuilding the image to make sure all parts are rebuilt[^compose_name_note].

```bash
sudo docker-compose build --no-cache php-7-2-fpm
```

### Build & Up

This will try to use a local version or rebuild the image with current context.

```bash
sudo docker-compose up --build -d
```

## Connect To Container

```bash
sudo docker exec -it php-7-2-fpm /bin/bash
```

# Disclaimer

This Nginx + PHP-FPM 7.2 build environment should ***NOT*** be used anywhere near a ***production*** environment. This build is for showcasing legacy systems that simple would not run in modern environments & as such it is littered with security holes and exploitation's.

[^docker_pull_cmd_note]: Use `docker pull ewc2020/web:php-7-2-fpm` to get a copy of the image.

[^npm_version_note]: Uses a `.env` ***build-arg*** called ***NPM_VERSION*** to specify the npm version.

[^multi_stage_builds_note]: Used mostly in ***Multi Stage*** image builds.

[^compose_name_note]: The `php-7-2-fpm` container name to build the image for.
