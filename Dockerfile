FROM mysql:5.7

ADD ./certs /etc/mysql/certs
ADD ./users.sql /docker-entrypoint-initdb.d/users.sql

RUN chown -R mysql:mysql /etc/mysql/certs
RUN chown -R mysql:mysql /docker-entrypoint-initdb.d