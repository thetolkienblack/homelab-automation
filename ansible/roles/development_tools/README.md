Developement_Tools
=========

This role installs some of the required development tools that i need to use, such as nodejs, npm, graphiz, starship and terraform.

Requirements
------------

Currently, the supported operating systems supported are:
- Debian based (like Ubuntu, Mint, PopOS, etc.).
  - It's using Jinja template to create a repository in Debian sistem.

Dependencies
------------
It's depending, on a common role.

Variables
------------
In the [main.yml](./defaults/main.yml) file has the following variables set:
- `openjdk_ver` - The version of the JDK installed

Example Playbook
----------------
    - hosts: servers
      roles:
         - role: common

License
-------

BSD

