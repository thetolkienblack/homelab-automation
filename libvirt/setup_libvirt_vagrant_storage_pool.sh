#!/bin/sh

sudo mkdir -p /mnt/storage/vagrant
virsh pool-define-as vagrant-pool dir - - - - "/mnt/storage/vagrant"
virsh pool-build vagrant-pool
virsh pool-start vagrant-pool
virsh pool-autostart vagrant-pool
