Host Setup
=========

This Ansible role is designed to set up and configure a host system, particularly for Debian-based distributions. It includes tasks for replacing the `sources.list` file, installing prerequisite packages, and setting up system tools.

Requirements
------------

- Ansible version 2.1 or higher.
- A Debian-based operating system.

Role Variables
--------------

This role does not currently define any variables in `vars/main.yml`. However, the following variables are used in the templates:

- `ansible_distribution_release`: Used in the `sources.list.j2` template to specify the Debian release.

Dependencies
------------

This role depends on the `common` role, as specified in `meta/main.yml`.

Example Playbook
----------------

Here is an example of how to use this role:

```yml
- hosts: servers
  roles:
    - role: host_setup
```

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
