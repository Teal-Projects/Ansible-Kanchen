#!/bin/bash                                                                                                                                                                                                      

git submodule add -b master ssh://git@stash.neofonie.de:7999/~monnin/ansible-role-docker.git
git submodule add -b master ssh://git@stash.neofonie.de:7999/~monnin/ansible-role-flannel.git
git submodule add -b master ssh://git@stash.neofonie.de:7999/~monnin/ansible-role-etcd.git
git submodule add -b master ssh://git@stash.neofonie.de:7999/~monnin/ansible-role-kube_master.git
git submodule add -b master ssh://git@stash.neofonie.de:7999/~monnin/ansible-role-vagrant.git
git submodule add -b master ssh://git@stash.neofonie.de:7999/~monnin/ansible-role-dev_setup.git
git submodule init
