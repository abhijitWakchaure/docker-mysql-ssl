FROM mysql:5.7

# Generated SSL certificates will be placed inside $CERTS_ROOT/certs
ENV CERTS_ROOT /etc/mysql

RUN apt-get update && apt-get -y upgrade \
	&& apt-get install -y --no-install-recommends curl python3 \
	&& rm -rf /var/lib/apt/lists/*

ADD ./createCerts.sh ${CERTS_ROOT}
ADD ./docker-entrypoint-custom.sh /
ADD ./initDB.sql /docker-entrypoint-initdb.d/initDB.sql

# ENV DEV_MODE true

RUN chown -R mysql:mysql /docker-entrypoint-initdb.d

ENTRYPOINT [ "/docker-entrypoint-custom.sh"]