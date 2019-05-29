INVENTORY_FILE := inventory
SSH_KEY_FILE := terra.key

help:
        @echo This terraform config creates instances for nextcloud demo
        @echo and ouputs an ansible inventory file and an ssh private key
        @echo Default values are stored in terraform.tfvars
        @echo
        @echo Usage:
        @echo To build and ouput ansible inventory file:
        @echo make $(INVENTORY_FILE)
        @echo
        @echo to tear down the test environment:
        @echo make teardown \(confirm with \'yes\'\)
        @echo
        @echo to test the inventory file run \'ANSIBLE_HOST_KEY_CHECKING=False ansible -i inventory base -m ping\'

.PHONY: build teardown ansible-inventory

build:
        @terraform init
        @terraform plan
        @terraform apply

teardown:
        @terraform destroy
        @rm -f $(SSH_KEY_FILE) > /dev/null
        @rm -f $(INVENTORY_FILE) > /dev/null

$(SSH_KEY_FILE):
        @terraform output ssh_private_key > $(SSH_KEY_FILE)
        @chmod 600 $(SSH_KEY_FILE)

$(INVENTORY_FILE): build $(SSH_KEY_FILE)
        @echo "[all:vars]" > $(INVENTORY_FILE)
        @echo "ansible_ssh_private_key_file=$(SSH_KEY_FILE)" >> $(INVENTORY_FILE)
        @echo "ansible_ssh_common_args='-o StrictHostKeyChecking=no'" >> $(INVENTORY_FILE)
        @terraform output ansible_inventory >> $(INVENTORY_FILE)
