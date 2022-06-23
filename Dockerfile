FROM mysql:5.7

# Generated SSL certificates will be placed inside $CERTS_ROOT/certs
ENV CERTS_ROOT /etc/mysql

ADD ./createCerts.sh ${CERTS_ROOT}
ADD ./users.sql /docker-entrypoint-initdb.d/users.sql

# Run the script to generate SSL certs on the fly
RUN /bin/bash -c "$CERTS_ROOT/createCerts.sh"

# Take the ownership for dirs as mysql is running with non-root user
RUN chown -R mysql:mysql ${CERTS_ROOT}
RUN chown -R mysql:mysql /docker-entrypoint-initdb.d