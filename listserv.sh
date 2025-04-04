#!/bin/bash

# This bash script tells you what services are running
# used for educational porpouses
#
# Tecnologico Nacional De México
#        Campus Cuautla
# Subject: Administración de redes
# Teacher: Mtro. Victor Manuel Ayala Lara
# Author: Sergio Gabriel Rodríguez Torres
#
# Services:
# HTTP server
# DNS server
# DHCP server

# ======================================== #
#                 DISTROS                  #
# ======================================== #
# NOTE: if your distro is not here be free to modify it
ubuntu="UbuntuLinux"
manjaro="ManjaroLinux"

os=$(lsb_release -is)
echo "OS ID: ${os}"

# ======================================== #
#                 DNS                      #
# ======================================== #
# For DNS server we are using bind9
# by default, the server name is bind9.servcice
# but also works with named.service
#
# On ubuntu, this service can be invoked with bind9
dns_server="bind9"

if [[ ${os} == ${manjaro} ]]; then
    dns_server="named"
fi


# ======================================== #
#                 HTTP                     #
# ======================================== #
# For HTTP server we are using apache http
# by default, the apache server name is apache2.service
# but it can change between distros
http_server="apache2"

if [[ ${os} == ${manjaro} ]]; then
    http_server="httpd" # On arch linux based systems, this is the name of the package
fi


# ======================================== #
#                 MAIN                     #
# ======================================== #
# Once all the services are defined, then list which services are running
# Example:
# Active:
# http.service
#
# Inactive:
# http.service

services=("${dns_server}" "${http_server}")

# Use this for loop to check if all services are listed
# for service in ${services}; do
#     echo ${services}
# done

echo "Active:"
for service in ${services[@]}; do
    if systemctl is-active --quiet "${service}"; then
        echo "${service}"
    fi
done

echo ""

echo "Inactive:"
for service in ${services[@]}; do
    if ! systemctl is-active --quiet "${service}"; then
        echo "${service}"
    fi
done

