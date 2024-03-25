#!/bin/bash
/usr/lib/rstudio-server/bin/rserver --server-daemonize=0 --server-app-armor-enabled=0 > /proc/1/fd/1 2>/proc/1/fd/2 &
su -c 'export PATH=/home/sccity/.local/bin:$PATH \
       && cd /home/sccity \
       && if [[ ! -f /home/sccity/.jupyter/jupyter_lab_config.py ]]; then jupyter-lab --generate-config; fi \
       && if [[ ! -f /home/sccity/.jupyter/jupyter_server_config.json ]]; then cp -fR /app/jupyter_server_config.json /home/sccity/.jupyter/; fi \
       && /home/sccity/.local/bin/jupyter lab --allow-root --ip=0.0.0.0 --no-browser' sccity > /proc/1/fd/1 2>/proc/1/fd/2
