FROM mysql:5.7

# Generated SSL certificates will be placed inside $CERTS_ROOT/certs
ENV CERTS_ROOT /etc/mysql

RUN apt-get update && apt-get -y upgrade \
	&& apt-get install -y --no-install-recommends curl python3 \
	&& rm -rf /var/lib/apt/lists/*

ADD ./createCerts.sh ${CERTS_ROOT}
ADD ./deploy-server.sh /
ADD ./initDB.sql /docker-entrypoint-initdb.d/initDB.sql

# ENV DEV_MODE true

# Run the script to generate SSL certs on the fly
RUN /bin/bash -c "$CERTS_ROOT/createCerts.sh"

# Take the ownership for dirs as mysql is running with non-root user
RUN chown -R mysql:mysql ${CERTS_ROOT}
RUN chown -R mysql:mysql /docker-entrypoint-initdb.d

ENTRYPOINT [ "/deploy-server.sh"]