#!/bin/bash

# mirror CryptStore Masters to BigData Masters
#rsync -av /run/media/daniel/CryptStore/Masters/ /mnt/BigData/Photos/Masters/ --delete --progress

# mirror CryptStore Darktable Settings to BigData Darktable Settings
#rsync -av /run/media/daniel/CryptStore/Darktable/ /mnt/BigData/Darktable/ --delete --progress

# mirror CryptStore Masters to DashwoodStore Masters
rsync -avz /run/media/daniel/CryptStore/Masters/ daniel@172.16.3.10:/mnt/storage/DashwoodStore/Photos/Masters/ --delete --progress

# mirror CryptStore Darktable Settings to DashwoodStore Darktable Settings
rsync -avz /run/media/daniel/CryptStore/Darktable/ daniel@172.16.3.10:/mnt/storage/DashwoodStore/Photos/Masters/Darktable/ --delete --progress
