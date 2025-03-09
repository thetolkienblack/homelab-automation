#!/bin/bash

# Stop on any error
set -e

echo "🚀 Removing existing br0 and enp14s0 configurations..."
nmcli connection delete br0 || true
nmcli connection delete enp14s0 || true

echo "✅ Creating new bridge br0..."
nmcli connection add type bridge autoconnect yes con-name br0 ifname br0

echo "🔗 Adding enp14s0 as a slave to br0..."
nmcli connection add type bridge-slave autoconnect yes con-name br0-slave ifname enp14s0 master br0

echo "🛠 Setting static IP and DNS for br0..."
nmcli connection modify br0 ipv4.addresses 192.168.50.54/24
nmcli connection modify br0 ipv4.gateway 192.168.50.1
nmcli connection modify br0 ipv4.dns "192.168.50.54,192.168.50.1,45.90.28.252"
nmcli connection modify br0 ipv4.method manual

echo "🔄 Restarting NetworkManager and bringing up br0..."
systemctl restart NetworkManager
nmcli connection up br0
nmcli connection up br0-slave

echo "🧹 Removing all existing Libvirt VMs and networks..."
# Destroy and undefine all VMs
for vm in $(virsh list --all --name); do
    virsh destroy "$vm" || true
    virsh undefine "$vm" --remove-all-storage || true
done

# Destroy and undefine all networks
for net in $(virsh net-list --all --name); do
    virsh net-destroy "$net" || true
    virsh net-undefine "$net" || true
done

echo "⚙️ Configuring Libvirt to use br0 as a bridge network..."
cat > /tmp/default.xml <<EOF
<network>
  <name>default</name>
  <forward mode='bridge'/>
  <bridge name='br0'/>
</network>
EOF

virsh net-define /tmp/default.xml
virsh net-start default
virsh net-autostart default

echo "✅ Setup complete! `br0` is now the primary bridge, and Libvirt VMs will get DHCP from the router."
