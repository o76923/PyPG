I wanted the latest version of python and postgres to work together so I made
an image that uses the latest of each. Also included are psycopg2 to connect
to postgres from python and plpython3u to use python from postgres.

==Usage==

`FROM o76923/pypg
`

==Note==

This is built from [https://hub.docker.com/r/library/python/tags/3.6-alpine/|python:3.6-alpine] 
so it will start in python if you don't do anything more sensible. It's a base
image, what do you expect?