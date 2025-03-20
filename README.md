# docker-ansible
Ansible playbooks for docker containers

# Playbook
## Basic Setup Playbook
1. Update the packages
2. Install main packages (like vim, unzip, rar, openssl, cron, curl, gpg, python, htop)

## Development Tools Playbook
1. Upgrade the packages
2. Install development tools (firacode, nmap, openssh-server, vagrant, libvirt, wireshark, dnsutils, speedtest, jq, git, openjdk, nodejs, npm, hashicorp)

## Nvidia Playbook
1. Upgrade packages
2. Install packages (dkms, build-essentials, ca-certificates, curl, gpg)
3. Enable non-free repository
4. Enabled i386 architecture packages
5. Update packages
6. Install nvidia non-free drivers
7. Enable Nvidia modesetting
8. Verify nvidia kernel mode is enabled

## Security Tools Playbook
1. Install security tools
   1. Netdata
   2. Crowdsec
   3. Digsys Falco
   4. Wazuh
   5. Trivvy
2. Install tailscale
   1. Authenticate with token
   2. Automatically connect
   3. OS DNS
3. Install PIA
   1. Automatically connect
   2. OS DNS
4. Configure tools and authenticate with token

## Docker Playbook
1. Install prerequisite packages
2. Add docker GPG
3. Add Docker repository
4. Update apt cache
5. Install docker packages
6. Check if nvidia kernel module is loaded
   1. Install nvidia container runtime
   2. Configure docker to use the runtime
7. Start docker
8. Configure GPU containers
   1. CodeProject
   2. Plex

## Kubernetes Playbook
1. Install kubernetes repo
2. Install kubeadm, kubens, kubectx

## Libvirt Playbook
1. Install libvirt
2. Create libvirt VMs
   1. Network VMs (DNS + Reverse proxy)
   2. Services VM
   3. HomeAssistantVM
3. Install basic setup
4. Install Security tools
   1. Agents to be installed and communicate with the baseOS
5. Install Docker container


# Open Questions
1. Use Jinja2 templates
   1. Docker containers
   2. Crowdsec configs
   3. Wazuh configs
   4. 