network_tools
=============

An Ansible role to install and configure essential network utility tools on Debian-based systems.

This role provides common command-line tools required for network diagnostics, troubleshooting, and monitoring.

Requirements
------------

- Debian-based operating system (Debian 10+, Ubuntu 20.04+)
- `apt` package manager

Role Variables
--------------

This role does not require any variables to be set by default, but you can override the package list if desired.

Available variables:

```yaml
network_tools_packages:
  - curl
  - gnupg2
  - wget
  - openssl
  - openssh-client
  - s-tui
  - smem
  - tcpdump
  - python3
  - python3-pip
  - python3-venv
  - htop
  ```