I wanted the latest version of python and postgres to work together so I made
an image that uses the latest of each. Also included are psycopg2 to connect
to postgres from python and plpython3u to use python from postgres.

==Usage==

To use this as a base image (as is designed), include the following as the first line. 

`
FROM o76923/pypg
`

To run this image when testing things, run the following in the command line

`docker run -it o76923/pypg`

or

`docker run -it --entrypoint=/bin/sh o76923/pypg`

to run from the terminal instead.

==Environmental Variables==
* LANG="en_US.utf8"
** Pretend to set the locale to english with UTF-8. Note that alpine does not yet
    support this since musl doesn't. But it reduces the number of apparent errors
    when compiling.
* LD_LIBRARY_PATH="/usr/local/pgsql/lib/"
** Necessary so libpq can be found by psycopg2
* PATH="$PATH:/usr/local/pgsql/bin/"
** Add all the pg_* commands and initdb to the path
* PG_MAJOR=9.6
** Postgres version, technically major and minor version based on the definitions for
    versions prior to 10
* PG_MINOR=9.6.3
** Technically the sub version or sub-minor version or something like that.
* PGDATA="/app/pgdata/"
** postgres's data is stored by default in /app/pgdata.

