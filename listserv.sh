#!/bin/bash

# This bash script tells you what services are running
#
# NOTE: if your distro is not here be free to modify it
#
# The list is the following
# HTTP server
# DNS server
# DHCP server

# ======================================== #
#                 DISTROS                  #
# ======================================== #
ubuntu="UbuntuLinux"
manjaro="ManjaroLinux"

echo "OS ID: $(lsb_release -is)"

# ======================================== #
#                 HTTP                     #
# ======================================== #
# For HTTP server we are using apache http
# by default, the apache server name is apache2.service
# but it can change between distros
apache_server="apache2.service"

if [[ ${apache_server} == ${manjaro} ]]; then
    apache_server="httpd" # On arch linux based systems, this is the name of the package
fi
