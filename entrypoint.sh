#!/bin/sh
su-exec postgres pg_ctl -D $PGDATA start
