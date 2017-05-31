FROM python:3.6-alpine
MAINTAINER James Endicott <james.endicott@colorado.edu>

ENV PATH=$PATH:/usr/local/pgsql/bin/ \
    PG_MAJOR=9.6 \
    PG_MINOR=9.6.3

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
   && make -j 20 install-strip \
   && cd src/pl/plpython/ \
   && make -j 20 install \
   && cd /tmp \
   && rm -r postgresql-$PG_MINOR \
   && pip install psycopg2 \
   && apk --no-cache del --purge build-deps