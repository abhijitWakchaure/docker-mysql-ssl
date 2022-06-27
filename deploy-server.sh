#!/usr/bin/env bash
# Author: Abhijit Wakchaure <awakchau@tibco.com>

python3 -m http.server -d ${CERTS_ROOT}/certs &

exec /usr/local/bin/docker-entrypoint.sh mysqld
