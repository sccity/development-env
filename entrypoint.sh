#!/bin/bash
/usr/lib/rstudio-server/bin/rserver --server-daemonize=0 --server-app-armor-enabled=0 > /proc/1/fd/1 2>/proc/1/fd/2 &
/usr/local/bin/jupyter lab --allow-root --ip=0.0.0.0 --no-browser > /proc/1/fd/1 2>/proc/1/fd/2