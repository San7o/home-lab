#!/bin/sh

#
# Connect to eduroam network
# ==========================
#

# Edit these variables based on your configuration
DOMAIN=unitn.it
EMAIL=name.surname@$DOMAIN
PASSWORD="<password-here>"
WIFI_INTERFACE="wlo1"
SSID="eduroam"

nmcli con add \
  type wifi \
  con-name $SSID \
  ifname $WIFI_INTERFACE \
  ssid $SSID \
  wifi-sec.key-mgmt "wpa-eap" \
  802-1x.identity $EMAIL \
  802-1x.password $PASSWORD \
  802-1x.system-ca-certs "yes" \
  802-1x.domain-suffix-match $DOMAIN \
  802-1x.eap "peap" \
  802-1x.phase2-auth "mschapv2"
  
nmcli connection up $SSID
