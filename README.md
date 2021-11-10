[![License BSD-2-Clause](https://img.shields.io/badge/License-BSD--2--Clause-blue.svg)](https://opensource.org/licenses/BSD-2-Clause)
[![License MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

# `acmesh-netcup`
Welcome to `acmesh-netcup` 🎉

`acmesh-netcup` is a simple [acme.sh](https://github.com/acmesh-official/acme.sh) based container with a trivial helper
script easily to issue p384 certificates using the [netcup](https://netcup.de/) DNS API.

## Example
See the [Docker-Compose.yml](Docker-Compose.yml) file as example. Then simply execute
`docker-compose run certbot-netcup` to issue the certificates and copy them to the mounted volume.