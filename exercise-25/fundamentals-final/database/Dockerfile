FROM postgres:9.6

COPY pg_hba.conf /usr/share/postgresql/9.6/pg_hba.conf
COPY postgresql.conf /usr/share/postgresql/9.6/postgresql.conf

COPY init-db.sql /docker-entrypoint-initdb.d/init-db.sql

ENV POSTGRES_USER="gordonuser"
ENV POSTGRES_DB="ddev"

