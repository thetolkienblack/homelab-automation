Role Name
=========

`vagrant_alpine` - An Ansible role to configure and provision Alpine Linux VMs using Vagrant with the Libvirt provider.

Requirements
------------

- Vagrant must be installed on the host system.
- The `libvirt` provider must be installed and configured.
- The host system should have Ansible installed to render the templates and execute the playbooks.

Role Variables
--------------

The following variables can be set for this role:

### Defaults (defined in `defaults/main.yml`):
- `disk_size`: The size of the VM's primary disk (e.g., `10GB`).
- `ram_memory`: The amount of RAM allocated to the VM (e.g., `1024` for 1GB).
- `cpu_core`: The number of CPU cores allocated to the VM.
- `storage_pool_name`: The name of the Libvirt storage pool.
- `storage_default_prefix`: The default prefix for storage volumes.
- `vm_name`: The name of the VM.
- `vm_hostname`: The hostname of the VM.
- `network_name`: The network type (e.g., `public_network` or `private_network`).
- `bridge_interface`: The bridge interface to use for networking.
- `synced_host_folder_dir`: The host directory to sync with the VM.
- `synced_guest_folder_dir`: The guest directory to sync with the host.
- `host_ssh_file`: The SSH public key file to add to the VM's authorized keys.
- `nameservers`: A list of DNS nameservers to configure in the VM.

### Example `nameservers` Variable:
```yaml
nameservers:
  - 192.168.50.54
  - 192.168.50.1
  - 45.90.28.252
```

Dependencies
------------

This role depends on the following roles:
- `common`
- `virt_tools`

Example Playbook
----------------

Here is an example of how to use this role in a playbook:

```yaml
- hosts: localhost
  roles:
    - role: vagrant_alpine
      vars:
        disk_size: "20GB"
        ram_memory: 2048
        cpu_core: 2
        storage_pool_name: "default"
        storage_default_prefix: "alpine_vm"
        vm_name: "alpine_test"
        vm_hostname: "alpine-vm"
        network_name: "public_network"
        bridge_interface: "virbr0"
        synced_host_folder_dir: "/path/to/host/folder"
        synced_guest_folder_dir: "/path/to/guest/folder"
        host_ssh_file: "/path/to/host/id_rsa.pub"
        nameservers:
          - 8.8.8.8
          - 8.8.4.4
```

License
-------

MIT

Author Information
------------------

**Author:** thetolkienblack  
**Company:** Graylock
