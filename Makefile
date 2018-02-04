
all: preview ack deploy restart log
	echo "Deployed and restarted"

.PHONY: preview
preview:
	rsync --progress --partial --exclude ".git" --dry-run -avz --no-perms --checksum --no-owner --no-group ./ root@nas:/mnt/user/appdata/home-assistant/

.PHONY: ack
ack:
	read -p "Press [Enter] to deploy and restart Home Assistant if this looks ok..."

.PHONY: deploy
deploy:
	rsync --progress --partial --exclude ".git" -avz --no-perms --checksum --no-owner --no-group ./ root@nas:/mnt/user/appdata/home-assistant/

.PHONY: restart
restart:
	ssh nas docker restart home-assistant

.PHONY: log
log:
	ssh nas tail -f /mnt/user/appdata/home-assistant/home-assistant.log

.PHONY: ozw
ozw:
	ssh nas tail -f /mnt/user/appdata/home-assistant/OZW_Log.txt
