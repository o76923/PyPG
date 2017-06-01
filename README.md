I wanted the latest version of python and postgres to work together so I made
an image that uses the latest of each. Also included are psycopg2 to connect
to postgres from python and plpython3u to use python from postgres.

## Usage

To use this as a base image (as it is designed), include the following as the 
first line. 

```dockerfile
FROM o76923/pypg
```

To test this image, you can get to the shell with the following

```bash
docker run -it --entrypoint=/bin/sh o76923/pypg
```

to run from the terminal instead.

## Environmental Variables
<dl>
    <dt>LANG="en_US.utf8"</dt>
    <dd>Pretend to set the locale to english with UTF-8. Note that alpine does
        not yet support this since musl doesn't. But it reduces the number of 
        apparent errors when compiling.</dd>
    <dt>LD_LIBRARY_PATH="/usr/local/pgsql/lib/"</dt>
    <dd>Necessary so libpq can be found by psycopg2.</dd>
    <dt>PATH="$PATH:/usr/local/pgsql/bin/"</dt>
    <dd>Add all the pg_* commands and initdb to the path.</dd>
    <dt>PG_MAJOR=9.6</dt>
    <dd>Postgres version, technically major and minor version based on the 
        definitions for versions prior to 10.</dd>
    <dt>PG_MINOR=9.6.3</dt>
    <dd>Technically the sub version or sub-minor version or something like 
        that.</dd>
    <dt>PGDATA="/app/pgdata/"</dt>
    <dd>postgres's data is stored by default in /app/pgdata.</dd>
    <dt>N_CORES=20</dt>
    <dd>Number of cores to use when building and launching postgres.</dd> 
</dl>
