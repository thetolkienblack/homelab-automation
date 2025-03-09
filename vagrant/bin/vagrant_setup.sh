#!/bin/bash

# Function to detect Desktop Environment
detect_de() {
    if [ -n "$XDG_CURRENT_DESKTOP" ]; then
        echo "$XDG_CURRENT_DESKTOP" | tr '[:upper:]' '[:lower:]'
    elif [ -n "$DESKTOP_SESSION" ]; then
        echo "$DESKTOP_SESSION" | tr '[:upper:]' '[:lower:]'
    else
        echo "unknown"
    fi
}

# Install required dependencies
echo "[+] Installing required packages..."
sudo apt update
sudo apt install -y libvirt-daemon-system libvirt-clients qemu-kvm vagrant vagrant-libvirt policykit-1 mkisofs

# Add the user to libvirt and kvm groups
echo "[+] Adding user to libvirt and kvm groups..."
sudo usermod -aG libvirt,kvm $USER
newgrp libvirt

# Detect Desktop Environment and Install Polkit Agent
DE=$(detect_de)
echo "[+] Detected Desktop Environment: $DE"

case "$DE" in
    *"plasma"*) 
        echo "[+] Installing Polkit agent for KDE..."
        sudo apt install -y polkit-kde-agent-1
        polkit_agent_cmd="/usr/libexec/polkit-kde-authentication-agent-1"
        ;;
    *"gnome"*)
        echo "[+] Installing Polkit agent for GNOME..."
        sudo apt install -y policykit-1-gnome
        polkit_agent_cmd="/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
        ;;
    *"xfce"*)
        echo "[+] Installing Polkit agent for XFCE..."
        sudo apt install -y policykit-1-gnome
        polkit_agent_cmd="/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1"
        ;;
    *"lxqt"*)
        echo "[+] Installing Polkit agent for LXQt..."
        sudo apt install -y lxqt-policykit
        polkit_agent_cmd="/usr/lib/lxqt-policykit-agent"
        ;;
    *"mate"*)
        echo "[+] Installing Polkit agent for MATE..."
        sudo apt install -y mate-polkit
        polkit_agent_cmd="/usr/lib/mate-polkit/polkit-mate-authentication-agent-1"
        ;;
    *)
        echo "[!] No specific Polkit agent found for your DE."
        polkit_agent_cmd=""
        ;;
esac

# Start Polkit agent
if [ -n "$polkit_agent_cmd" ]; then
    echo "[+] Starting Polkit agent..."
    nohup $polkit_agent_cmd >/dev/null 2>&1 &
fi

# Configure Polkit rules for libvirt
echo "[+] Setting Polkit rules for libvirt..."
sudo bash -c 'cat > /etc/polkit-1/rules.d/50-libvirt.rules' <<EOF
polkit.addRule(function(action, subject) {
    if (action.id == "org.libvirt.unix.manage" &&
        subject.isInGroup("libvirt")) {
        return polkit.Result.YES;
    }
});
EOF

# Restart services
echo "[+] Restarting services..."
sudo systemctl restart polkit
sudo systemctl restart libvirtd

# Install Vagrant Plugins
echo "[+] Installing Vagrant plugins..."
vagrant plugin install \
  #vagrant-puppet-install      # Installs Puppet automatically on the guest \
  vagrant-hostmanager        # Manages /etc/hosts for multi-machine setups \
  vagrant-hosts              # Manages host entries within Vagrant \
  vagrant-flow               # Enhances Vagrant workflows with new commands \
  #vagrant-digitalocean       # Adds DigitalOcean provider support \
  vagrant-libvirt            # Enables Libvirt provider support \
  #vagrant-lxd                # Enables LXD provider support \
  vagrant-managed-servers    # Allows Vagrant to manage remote servers \
  #vagrant-proxmox            # Enables Proxmox provider support \
  copy-my-conf               # Syncs user config files into the guest VM \
  vagrant-ansible-local      # Runs Ansible provisioner locally within guest VM \
  #vagrant-docker-compose     # Adds Docker Compose support for Vagrant \
  vagrant-cloudinit          # Supports Cloud-init provisioning \
  vagrant-gatling-rsync      # Provides faster rsync-based file synchronization \
  #vagrant-host-shell         # Runs host shell commands from within the guest \
  #vagrant-notify             # Sends desktop notifications from the guest VM \
  vagrant-ip-show            # Displays guest VM IP address in terminal \
  vagrant-vlan               # Enables VLAN tagging support for Vagrant networks \
  vagrant-netinfo            # Displays network details for Vagrant VMs \
  vagrant-env                # Manages environment variables in Vagrantfile \
  vagrant-ec2setup           # Automates EC2 instance provisioning
  vagrant-disksize

echo "[+] All Vagrant plugins installed!"

echo "[+] Setup complete. You may need to log out and log back in for changes to take effect."

