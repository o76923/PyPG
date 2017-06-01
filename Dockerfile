FROM python:3.6-alpine
MAINTAINER James Endicott <james.endicott@colorado.edu>
WORKDIR /app
ENTRYPOINT ["/bin/sh", "-c", "./entrypoint.sh"]

ENV LANG="en_US.utf8" \
    LD_LIBRARY_PATH="/usr/local/pgsql/lib/" \
    PATH="$PATH:/usr/local/pgsql/bin/" \
    PG_MAJOR=9.6 \
    PG_MINOR=9.6.3 \
    PGDATA="/app/pgdata/" \
    N_CORES=20

RUN apk --no-cache add su-exec \
    && apk --no-cache add --virtual build-deps \
       bison \
       flex \
       g++ \
       linux-headers \
       make \
       openssl \
       perl \
       readline-dev \
       tar \
       zlib-dev \
   && cd /tmp/ \
   && wget https://ftp.postgresql.org/pub/source/v$PG_MINOR/postgresql-$PG_MINOR.tar.bz2 \
   && tar -xjf postgresql-$PG_MINOR.tar.bz2 \
   && rm postgresql-$PG_MINOR.tar.bz2 \
   && cd postgresql-$PG_MINOR \
   && ./configure  --with-python PYTHON=/usr/local/bin/python \
   && make -j $N_CORES install-strip \
   && cd src/pl/plpython/ && make -j $N_CORES install && cd /tmp/postgresql-$PG_MINOR/ \
   && cd src/interfaces/libpq/ && make -j $N_CORES install && cd /tmp/postgresql-$PG_MINOR/ \
   && cd /tmp \
   && rm -r postgresql-$PG_MINOR \
   && pip install psycopg2 \
   && apk --no-cache del --purge build-deps \
   && mkdir -p /app/pgdata /run/postgresql \
   && chmod 700 /app/pgdata \
   && chown -R postgres /app/pgdata \
   && chmod g+s /run/postgresql \
   && chown -R postgres /run/postgresql

COPY postgresql.conf /app/conf/postgresql.conf

RUN su-exec postgres pg_ctl initdb -D /app/pgdata  -o "-E 'UTF-8'" \
    && rm -f /app/pgdata/postgresql.conf \
    && echo "host all all 0.0.0.0/0 md5" >> /app/pgdata/pg_hba.conf \
    && mv /app/conf/postgresql.conf /app/pgdata/postgresql.conf \
    && echo "max_parallel_workers_per_gather=$N_CORES" >> /app/pgdata/postgresql.conf

