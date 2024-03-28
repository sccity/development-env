#!/bin/bash
if [ -d "/var/run/dbus" ]; then
    rm /var/run/dbus/pid
else
    mkdir -p /var/run/dbus
fi
/usr/bin/dbus-daemon --system
/usr/sbin/avahi-daemon --daemonize --no-drop-root
/usr/lib/rstudio-server/bin/rserver --server-daemonize=0 --server-app-armor-enabled=0 --auth-none=1 > /proc/1/fd/1 2>/proc/1/fd/2 &
su -c 'export PATH=/home/sccity/.local/bin:$PATH \
       && cd /home/sccity \
       && /home/sccity/.local/bin/jupyter lab --allow-root --ip=0.0.0.0 --no-browser --LabApp.token=""' sccity > /proc/1/fd/1 2>/proc/1/fd/2