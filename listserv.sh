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
# DNS
# DHCP
# SSH
# FTP
# TFTP
# NFS
# HTTP
# SMTP
# IMAP
# POP3

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
#                 DHCP                     #
# ======================================== #
# For DHCP server we are using the official isc dhcp server
# by default, the server name is isc-dhcp-server.service
dhcp_server="isc-dhcp-server"

if [[ ${os} == ${manjaro} ]]; then
    dhcp_server="kea-dhcp4" # isc-dhcp-server is deprecated in arch, hence, kea must be used
fi


# ======================================== #
#                  SSH                     #
# ======================================== #
# For SSH server we are using the Open SSH implementation
# by default, the server name is openssh-server.service
ssh_server="openssh-server"

if [[ ${os} == ${manjaro} ]]; then
    ssh_server="sshd" # This is the name of the package on arch based systems
fi


# ======================================== #
#                  FTP                     #
# ======================================== #
# For FTP we are using the "Very Secure" implementation of ftp
# by default, the server name is vsftpd.service
ftp_server="vsftpd"



# ======================================== #
#                 TFTP                     #
# ======================================== #
# For TFTP we are using tftp-hpa
# by default, the server name is tfpt-hpa.service
tftp_server="tftp-hpa"

if [[ ${os} == ${manjaro} ]]; then
    tfpt_server="tftpd" # On arch based systems, this is the name of the package
fi


# ======================================== #
#                  NFS                     #
# ======================================== #
# For NFS we are using nfs-kernel-server
# by default, the server name is nfs-kernel-server.service
nfs_server="nfs-kernel-server"

if [[ ${os} == ${manjaro} ]]; then
    nfs_server="nfs-server"
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
#                  SMTP                    #
# ======================================== #
# For SMTP we are using postfix
# by default, the server name is postfix.service
smtp_server="postfix"


# ======================================== #
#              IMAP and POP3               #
# ======================================== #
# for imap and pop3 we are using dovecot
# which includes both
# if you are using different packages for this services
# modify the script, declare both packages in this section

# Example
# imap_server="your_imap_server"
# pop3_server="your_pop3_server"

# In the main section, on services array, add both variables
imap_pop3_server="dovecot"


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

services=("${dns_server}" "${dhcp_server}" "${ssh_server}" "${ftp_server}" "${tfpt_server}" "${nfs_server}" "${http_server}" "${smtp_server}" "${imap_pop3_server}" )

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

