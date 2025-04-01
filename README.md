# docker-ansible
This repository contains Ansible playbooks for setting up a secure and efficient environment using Docker, Kubernetes, and Libvirt. The playbooks are designed to automate the installation and configuration of various tools and services, including security tools, development environments, and GPU support.

## Requirements
- Ansible 2.8 or higher
- Python 3.x
- Docker (for Docker playbooks)
- Kubernetes (for Kubernetes playbooks)
- Libvirt (for Libvirt playbooks)

## Overview
This repository contains the following main components:
1. Basic setup playbook
2. Development tools playbook
3. Nvidia playbook
4. Security tools playbook
5. Docker playbook
6. Kubernetes playbook
7. Libvirt playbook

## Directory Structure
- `ansible.cfg`: Ansible configuration file.
- `inventory`: Inventory file for specifying hosts and groups.
- `playbooks/`: Directory containing various Ansible playbooks.
  - `basic_setup.yml`: Basic setup playbook.
  - `dev_tools.yml`: Development tools playbook.
  - `nvidia.yml`: Nvidia playbook.
  - `security_tools.yml`: Security tools playbook.
  - `docker.yml`: Docker playbook.
  - `kubernetes.yml`: Kubernetes playbook.
  - `libvirt.yml`: Libvirt playbook.

## Usage
To run a specific playbook, use the following command:
```bash
ansible-playbook -i inventory playbooks/<playbook_name>.yml
```

## Examples
### Basic Setup Playbook
```bash
ansible-playbook -i inventory playbooks/basic_setup.yml
```

### Development Tools Playbook
```bash
ansible-playbook -i inventory playbooks/dev_tools.yml
```

### Nvidia Playbook
```bash
ansible-playbook -i inventory playbooks/nvidia.yml
```

### Security Tools Playbook
```bash
ansible-playbook -i inventory playbooks/security_tools.yml
```

### Docker Playbook
```bash
ansible-playbook -i inventory playbooks/docker.yml
```

### Kubernetes Playbook
```bash
ansible-playbook -i inventory playbooks/kubernetes.yml
```

### Libvirt Playbook
```bash
ansible-playbook -i inventory playbooks/libvirt.yml
```

## Notes
- Ensure that you have the necessary permissions to run the playbooks and install packages.
- Review each playbook before running it to understand what changes will be made to your system.

## License
This project is licensed under the MIT License. See the LICENSE file for details.

## Contributing
Contributions are welcome! Please create a pull request or open an issue if you have suggestions or improvements.

## Author
This project is maintained by [Your Name]. For more information, visit [Your Website or GitHub Profile].

# Ansible playbooks for docker containers
This repository contains Ansible playbooks for setting up a secure and efficient environment using Docker, Kubernetes, and Libvirt. The playbooks are designed to automate the installation and configuration of various tools and services, including security tools, development environments, and GPU support.

## Requirements
- Ansible 2.8 or higher
- Python 3.x
- Docker (for Docker playbooks)
- Kubernetes (for Kubernetes playbooks)
- Libvirt (for Libvirt playbooks)

## Overview
This repository contains the following main components:
1. Basic setup playbook
2. Development tools playbook
3. Nvidia playbook
4. Security tools playbook
5. Docker playbook
6. Kubernetes playbook
7. Libvirt playbook

## Directory Structure
- `ansible.cfg`: Ansible configuration file.
- `inventory`: Inventory file for specifying hosts and groups.
- `playbooks/`: Directory containing various Ansible playbooks.
  - `basic_setup.yml`: Basic setup playbook.
  - `dev_tools.yml`: Development tools playbook.
  - `nvidia.yml`: Nvidia playbook.
  - `security_tools.yml`: Security tools playbook.
  - `docker.yml`: Docker playbook.
  - `kubernetes.yml`: Kubernetes playbook.
  - `libvirt.yml`: Libvirt playbook.

## Usage
To run a specific playbook, use the following command:
```bash
ansible-playbook -i inventory playbooks/<playbook_name>.yml
```

## Examples
### Basic Setup Playbook
```bash
ansible-playbook -i inventory playbooks/basic_setup.yml
```

### Development Tools Playbook
```bash
ansible-playbook -i inventory playbooks/dev_tools.yml
```

### Nvidia Playbook
```bash
ansible-playbook -i inventory playbooks/nvidia.yml
```

### Security Tools Playbook
```bash
ansible-playbook -i inventory playbooks/security_tools.yml
```

### Docker Playbook
```bash
ansible-playbook -i inventory playbooks/docker.yml
```

### Kubernetes Playbook
```bash
ansible-playbook -i inventory playbooks/kubernetes.yml
```

### Libvirt Playbook
```bash
ansible-playbook -i inventory playbooks/libvirt.yml
```

## Notes
- Ensure that you have the necessary permissions to run the playbooks and install packages.
- Review each playbook before running it to understand what changes will be made to your system.

## License
This project is licensed under the MIT License. See the LICENSE file for details.

## Contributing
Contributions are welcome! Please create a pull request or open an issue if you have suggestions or improvements.

## Author
This project is maintained by [Your Name]. For more information, visit [Your Website or GitHub Profile].

## Ansible Playbooks for Docker Containers
This repository contains Ansible playbooks for setting up a secure and efficient environment using Docker, Kubernetes, and Libvirt. The playbooks are designed to automate the installation and configuration of various tools and services, including security tools, development environments, and GPU support.

## Requirements
- Ansible 2.8 or higher
- Python 3.x
- Docker (for Docker playbooks)
- Kubernetes (for Kubernetes playbooks)
- Libvirt (for Libvirt playbooks)

## Overview
This repository contains the following main components:
1. Basic setup playbook
2. Development tools playbook
3. Nvidia playbook
4. Security tools playbook
5. Docker playbook
6. Kubernetes playbook
7. Libvirt playbook

## Directory Structure
- `ansible.cfg`: Ansible configuration file.
- `inventory`: Inventory file for specifying hosts and groups.
- `playbooks/`: Directory containing various Ansible playbooks.
  - `basic_setup.yml`: Basic setup playbook.
  - `dev_tools.yml`: Development tools playbook.
  - `nvidia.yml`: Nvidia playbook.
  - `security_tools.yml`: Security tools playbook.
  - `docker.yml`: Docker playbook.
  - `kubernetes.yml`: Kubernetes playbook.
  - `libvirt.yml`: Libvirt playbook.

## Usage
To run a specific playbook, use the following command:
```bash
ansible-playbook -i inventory playbooks/<playbook_name>.yml
```
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

# TODO
- [ ] Create role to install vagrant vm
- [ ] Create role to install LXC vm
- [ ] Create role to install LXD vm
- [ ] Create role to install VM via libvirt

# Roles
## Base Setup
### Common

### Nvidia

### Starship

## System Administration
### Archive Tools

### Diagnostic Tools

### Cockpit

## Network Tools

## Development
### Development Tools

### Hashicorp

### NodeJS

### OpenJDK

### Python

## Virtualization
### Libvirt

### Lxc

### Lxd

### Vagrant

### Vagrant Alpine

### Podman

## Security Tools
### Graylog

### Graylog Agent

### Wazuh

### Trivvy

### Falco 

### Crowdsec

### Crowdsec Agent

### Netdata

### Netdata Agent