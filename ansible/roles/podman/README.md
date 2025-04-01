Podman Container Role
=====================

This Ansible role configures Podman containers on Debian-based systems. It installs Podman, Podman Compose, and related tools, sets up a default Podman machine, and optionally configures NVIDIA Container Toolkit and Cockpit Podman if applicable.

Requirements
------------

- A Debian-based operating system (e.g., Debian, Ubuntu).
- Ansible 2.9 or later.
- Root or sudo privileges on the target system.

Role Variables
--------------

The following variables can be set to customize the role:

| Variable           | Description                                      | Default Value       |
|--------------------|--------------------------------------------------|---------------------|
| `docker_username`  | Docker registry username for login.              | `""` (empty string) |
| `docker_password`  | Docker registry password for login.              | `""` (empty string) |
| `docker_registry`  | Docker registry URL (e.g., `docker.io`).         | `docker.io`         |

Dependencies
------------

This role depends on the following roles:

- `common`: Ensures common prerequisites are installed.
- `install_cockpit`: Installs and configures Cockpit.
- `nvidia_drivers`: Installs NVIDIA drivers if required.

Example Playbook
----------------

Here is an example of how to use this role:

```yaml
- hosts: all
  become: yes
  vars:
    docker_username: "your_docker_username"
    docker_password: "your_docker_password"
    docker_registry: "docker.io"
  roles:
    - podman_container
```

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
