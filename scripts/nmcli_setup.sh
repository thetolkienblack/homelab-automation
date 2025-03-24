#!/bin/sh
NMCLI_BRIDGE_NAME='br0'
NMCLI_IFACE_NAME='enp14s0'
NMCLI_BRIDGE_IP='192.168.50.54/24'
NMCLI_BRIDGE_GW='192.168.50.1'
NMCLI_BRIDGE_DNS='192.168.50.1 9.9.9.9 1.1.1.1'

# Ensure NetworkManager is installed and enabled
apt install -y network-manager
systemctl enable --now NetworkManager.service

# Delete any existing connections
nmcli connection delete "$NMCLI_BRIDGE_NAME" 2>/dev/null
nmcli connection delete "bridge-slave-$NMCLI_IFACE_NAME" 2>/dev/null

# Clone MAC address of the physical interface
CLONED_MAC=$(cat /sys/class/net/$NMCLI_IFACE_NAME/address)

# Add bridge interface
nmcli connection add type bridge ifname "$NMCLI_BRIDGE_NAME" con-name "$NMCLI_BRIDGE_NAME"
nmcli connection modify "$NMCLI_BRIDGE_NAME" \
  ipv4.addresses "$NMCLI_BRIDGE_IP" \
  ipv4.gateway "$NMCLI_BRIDGE_GW" \
  ipv4.dns "$NMCLI_BRIDGE_DNS" \
  ipv4.method manual \
  ipv6.method ignore \
  bridge.stp no \
  802-3-ethernet.cloned-mac-address "$CLONED_MAC" \
  connection.autoconnect yes

# Add the physical interface as a bridge slave
nmcli connection add type bridge-slave ifname "$NMCLI_IFACE_NAME" master "$NMCLI_BRIDGE_NAME" con-name "bridge-slave-$NMCLI_IFACE_NAME"
nmcli connection modify "bridge-slave-$NMCLI_IFACE_NAME" connection.autoconnect yes

# Bring up the connections
nmcli connection up "$NMCLI_BRIDGE_NAME"
nmcli connection up "bridge-slave-$NMCLI_IFACE_NAME"

echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf
sysctl -p