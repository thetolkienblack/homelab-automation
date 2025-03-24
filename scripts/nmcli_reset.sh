#!/bin/sh

NMCLI_BRIDGE_NAME='br0'
NMCLI_IFACE_NAME='enp14s0'
SLAVE_CONN_NAME="bridge-slave-$NMCLI_IFACE_NAME"

# Delete bridge and slave connections
nmcli connection delete "$NMCLI_BRIDGE_NAME" 2>/dev/null
nmcli connection delete "$SLAVE_CONN_NAME" 2>/dev/null

# Optional: delete any old configs that might be lingering
nmcli connection delete "$NMCLI_IFACE_NAME" 2>/dev/null

# Add default DHCP config back to the physical interface
nmcli connection add type ethernet ifname "$NMCLI_IFACE_NAME" con-name "$NMCLI_IFACE_NAME" ipv4.method auto ipv6.method auto

# Bring the connection up
nmcli connection up "$NMCLI_IFACE_NAME"