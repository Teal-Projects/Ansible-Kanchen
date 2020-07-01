.PHONY: list
list:
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'

.PHONY: deploy-local
deploy-local: packer-vagrant vagrant ansible

.PHONY:tools
tools:
	(cd bin ; /usr/bin/ruby2.5 -W2 tools-binaries.rb ; exit 0)

.PHONY:packer-vagrant
packer-vagrant: 
	(cd packer ; packer fix ubuntu.json; exit 0)
	(cd packer ; packer validate ubuntu.json; exit 0)
	(cd packer ; packer build -only=virtualbox-iso ubuntu.json ; exit 0)
  
.PHONY: vagrant
vagrant:
	vagrant destroy -f
	vagrant up

.PHONY: clean
clean:
	vagrant destroy -f

.PHONY: ansible-vagrant
ansible-vagrant:
	ansible-playbook --connection=ssh --timeout=30 --limit="master_node" --inventory-file=ansible/inventory/sample/hosts_vagrant.yaml -v ansible/playbooks/site.yml

.PHONY: ansible-cur
ansible-cur: export ANSIBLE_CONFIG = ansible/ansible.cfg
ansible-cur: 
	ansible-playbook --connection=ssh --timeout=30 --inventory-file=ansible/inventory/sample/hosts_cur-vm3.yaml -v ansible/playbooks/etcd.yml
