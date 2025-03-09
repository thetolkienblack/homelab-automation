#!/bin/bash

# VM Configuration
VM_NAME="dns_alpine_linux"
HOSTNAME="dns.graylock.eu"
DISK_PATH="/var/lib/libvirt/images/${VM_NAME}.qcow2"
ISO_PATH="/var/lib/libvirt/images/alpine-extended-3.20.3-x86_64.iso"  # Update ISO if needed
BRIDGE_IF="br0"
RAM_MB=1024
VCPUS=1
DISK_SIZE=10G
DNS_SERVERS="192.168.50.54 192.168.50.1 45.90.28.252"
SSH_KEY_SOURCE="/home/sidney/.ssh/id_ed25519.pub"
SSH_USER="root"

# Check if VM already exists
if virsh list --all | grep -q "$VM_NAME"; then
    echo "❌ VM '$VM_NAME' already exists. Exiting..."
    exit 1
fi

# Create disk image
echo "📦 Creating disk image for $VM_NAME..."
qemu-img create -f qcow2 "$DISK_PATH" "$DISK_SIZE"

# Install the VM using virt-install
echo "🚀 Installing $VM_NAME..."
virt-install \
  --name "$VM_NAME" \
  --os-variant "alpinelinux3.17" \
  --ram "$RAM_MB" \
  --vcpus "$VCPUS" \
  --disk path="$DISK_PATH",format=qcow2,size="${DISK_SIZE%G}" \
  --cdrom "$ISO_PATH" \
  --network bridge="$BRIDGE_IF",model=virtio \
  --graphics none \
  --console pty,target_type=serial \
  --noautoconsole \
  --virt-type kvm \
  --boot cdrom,hd

echo "✅ VM $VM_NAME created successfully!"

# Wait for the VM to boot and configure network
echo "⏳ Waiting for VM to boot and get an IP..."
sleep 20
IP=$(virsh domifaddr "$VM_NAME" | awk '/ipv4/ {print $4}' | cut -d'/' -f1)

if [ -z "$IP" ]; then
    echo "⚠️ VM did not get an IP. Check DHCP settings on bridge $BRIDGE_IF."
    exit 1
else
    echo "🌐 VM IP Address: $IP"
fi

# Configure networking, update repositories, install SSH and Ansible
echo "🛠 Configuring networking, SSH, repositories, and Ansible inside the VM..."

ssh-keygen -R "$IP"
sleep 5  # Allow VM to fully boot

ssh -o "StrictHostKeyChecking=no" "$SSH_USER@$IP" << EOF
    echo "🔧 Setting up networking and DNS..."
    echo "auto eth0" > /etc/network/interfaces
    echo "iface eth0 inet dhcp" >> /etc/network/interfaces
    echo "$HOSTNAME" > /etc/hostname
    rc-service networking restart

    echo "🔗 Mounting NFS share..."
    mkdir -p /mnt/data
    echo "/media/sidney/NAS/Homelab /mnt/data nfs defaults 0 0" >> /etc/fstab
    mount -a

    echo "🔑 Copying SSH key from host..."
    mkdir -p /root/.ssh
    echo "$(cat $SSH_KEY_SOURCE)" >> /root/.ssh/authorized_keys
    chmod 600 /root/.ssh/authorized_keys
    chown -R root:root /root/.ssh

    echo "📦 Updating Alpine Repositories..."
    echo "https://dl-cdn.alpinelinux.org/alpine/v3.20/main" > /etc/apk/repositories
    echo "https://dl-cdn.alpinelinux.org/alpine/v3.20/community" >> /etc/apk/repositories
    echo "https://dl-cdn.alpinelinux.org/alpine/latest-stable/main" >> /etc/apk/repositories
    echo "https://dl-cdn.alpinelinux.org/alpine/latest-stable/community" >> /etc/apk/repositories

    echo "📦 Updating packages and installing SSH & Ansible..."
    apk update && apk upgrade
    apk add openssh ansible
    rc-service sshd start
    rc-update add sshd
EOF

echo "✅ VM '$VM_NAME' is fully set up with DHCP, SSH, Ansible, and Alpine v3.20 repositories!"
