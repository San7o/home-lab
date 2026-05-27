USER       = lab
INVENTORY ?= inventory.ini
PLAYBOOK  ?= playbook.yaml

all: playbook

.PHONY: playbook
playbook:
	ansible-playbook -i $(INVENTORY) -u $(USER) $(PLAYBOOK)

.PHONY: verify
verify:
	ansible-inventory -i $(INVENTORY) --list

.PHONY: ping
ping:
	ansible myhosts -m ping -u $(USER) -i $(INVENTORY)
