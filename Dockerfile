FROM mysql

ADD ./certs /etc/mysql/certs

RUN chown -R mysql:mysql /etc/mysql/certs

