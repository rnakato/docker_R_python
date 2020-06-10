#!/bin/bash
port=$1
#rstudio-server start
/usr/lib/rstudio-server/bin/rserver --www-port $port
