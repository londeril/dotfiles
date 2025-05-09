#!/bin/bash

# mirror CryptStore Masters to BigData Masters
#rsync -av /run/media/daniel/CryptStore/Masters/ /mnt/BigData/Photos/Masters/ --delete --progress

# mirror CryptStore Darktable Settings to BigData Darktable Settings
#rsync -av /run/media/daniel/CryptStore/Darktable/ /mnt/BigData/Darktable/ --delete --progress

# mirror Masters to DashwoodStore Masters
rsync -av /home/daniel/Masters/ daniel@172.16.3.10:/mnt/storage/DashwoodStore/Photos/Masters/ --delete --progress

# mirror Video RAW to Backup Disk on Arandur
rsync -av /home/daniel/Videos/RAW_Footage/ daniel@172.16.3.10:/mnt/backup/RAW_Footage/

# mirror CryptStore Darktable Settings to DashwoodStore Darktable Settings
#rsync -avz /run/media/daniel/CryptStore/Darktable/ daniel@172.16.3.10:/mnt/storage/DashwoodStore/Darktable/ --delete --progress

# mirror Darktable Settings to CryptStore and DashwoodStore
rsync -av /home/daniel/.config/darktable/ daniel@172.16.3.10:/mnt/storage/DashwoodStore/Darktable/ --delete --progress
