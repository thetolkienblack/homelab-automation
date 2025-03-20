#!/bin/sh
NMCLI_BRIDGE_NAME=br0
NMCLI_IFACE_NAME=en0
NMCLI_BRIDGE_IP='192.168.50.222'
NMCLI_BRIDGE_GW='192.168.50.1'
NMCLI_BRIDGE_DNS='192.168.50.1 9.9.9.9 1.1.1.1'

apt install network-manager
systemctl start NetworkManager.service 
systemctl enable NetworkManager.service

nmcli connection delete $NMCLI_BRIDGE_NAME
nmcli connection delete bridge-slave-$NMCLI_IFACE_NAME
nmcli connection add type bridge ifname $NMCLI_BRIDGE_NAME con-name $NMCLI_BRIDGE_NAME
nmcli connection modify $NMCLI_BRIDGE_NAME ipv4.addresses $NMCLI_BRIDGE_IP
nmcli connection modify $NMCLI_BRIDGE_NAME ipv4.gateway $NMCLI_BRIDGE_GW
nmcli connection modify $NMCLI_BRIDGE_NAME ipv4.dns "$NMCLI_BRIDGE_DNS"
nmcli connection modify $NMCLI_BRIDGE_NAME ipv4.method manual
nmcli connection modify $NMCLI_BRIDGE_NAME ipv6.method ignore
nmcli connection modify $NMCLI_BRIDGE_NAME bridge.stp no
nmcli connection modify $NMCLI_BRIDGE_NAME autoconnect yes

nmcli connection add type bridge-slave ifname $NMCLI_IFACE_NAME master $NMCLI_BRIDGE_NAME
nmcli connection modify bridge-slave-$NMCLI_IFACE_NAME autoconnect yes
nmcli connection up bridge-slave-$NMCLI_IFACE_NAME

nmcli device reapply $NMCLI_BRIDGE_NAME
nmcli connection up $NMCLI_BRIDGE_NAME

dhclient -r $NMCLI_BRIDGE_NAME && dhclient $NMCLI_BRIDGE_NAME