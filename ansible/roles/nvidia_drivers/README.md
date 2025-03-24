nvidia_drivers
==============

An Ansible role to install and configure NVIDIA GPU drivers on Debian-based systems.  
It handles enabling `i386` architecture, installing kernel headers, required firmware, and the proprietary NVIDIA driver.

This role is useful for headless setups, compute workloads, or homelab environments where NVIDIA GPU support is required.

Requirements
------------

- Debian 11+ or Ubuntu 20.04+ system
- Root or sudo access
- `apt` package manager
- A compatible NVIDIA GPU

Role Variables
--------------

These are the default variables you can override:

```yaml
# Whether to enable i386 architecture support (needed for some 32-bit NVIDIA libs)
nvidia_enable_i386: true
```
# List of NVIDIA-related packages to install
nvidia_packages:
  - nvidia-driver
  - libnvidia-gl-470:i386  # Optional 32-bit support (adjust version as needed)

# Whether to install Linux headers automatically
nvidia_kernel_headers: true