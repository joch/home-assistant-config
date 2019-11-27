
all: preview ack deploy restart log
	echo "Deployed and restarted"

.PHONY: preview
preview:
	rsync --progress --partial --exclude ".git" --exclude "customize.yaml" --exclude "ui-lovelace.yaml" --exclude "automations.yaml" --dry-run -avz --no-perms --checksum --no-owner --no-group ./ joch@nas:/opt/home-assistant/

.PHONY: ack
ack:
	bash -c 'read -p "Press [Enter] to deploy and restart Home Assistant if this looks ok..."'

.PHONY: deploy
deploy:
	rsync --progress --partial --exclude ".git" --exclude "customize.yaml" --exclude "ui-lovelace.yaml" --exclude "automations.yaml" -avz --no-perms --checksum --no-owner --no-group ./ joch@nas:/opt/home-assistant/

.PHONY: back
back:
	rsync --progress --partial --exclude ".git" -avz --no-perms --checksum --no-owner --no-group joch@nas:/opt/home-assistant/customize.yaml ./customize.yaml
	rsync --progress --partial --exclude ".git" -avz --no-perms --checksum --no-owner --no-group joch@nas:/opt/home-assistant/automations.yaml ./automations.yaml
	rsync --progress --partial --exclude ".git" -avz --no-perms --checksum --no-owner --no-group joch@nas:/opt/home-assistant/.storage/lovelace ./ui-lovelace.yaml

.PHONY: restart
restart:
	ssh nas docker restart home-assistant

.PHONY: log
log:
	ssh nas tail -f /opt/home-assistant/home-assistant.log

.PHONY: ozw
ozw:
	ssh nas tail -f /opt/home-assistant/OZW_Log.txt
