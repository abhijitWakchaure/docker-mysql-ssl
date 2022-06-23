FROM mysql:5.7

ENV CERTS_ROOT /etc/mysql

ADD ./createCerts.sh ${CERTS_ROOT}
ADD ./users.sql /docker-entrypoint-initdb.d/users.sql

RUN /bin/bash -c "/etc/mysql/createCerts.sh"

RUN chown -R mysql:mysql ${CERTS_ROOT}
RUN chown -R mysql:mysql /docker-entrypoint-initdb.d