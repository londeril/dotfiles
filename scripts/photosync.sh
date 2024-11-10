#!/bin/bash

# mirror CryptStore Masters to BigData Masters
#rsync -av /run/media/daniel/CryptStore/Masters/ /mnt/BigData/Photos/Masters/ --delete --progress

# mirror CryptStore Darktable Settings to BigData Darktable Settings
#rsync -av /run/media/daniel/CryptStore/Darktable/ /mnt/BigData/Darktable/ --delete --progress

# copy local changes to CryptStore
rsync -av /home/daniel/Pictures/Masters/Kids/2024/ /run/media/daniel/CryptStore/Masters/Kids/2024/ --delete --progress
rsync -av /home/daniel/Pictures/Masters/Import/ /run/media/daniel/CryptStore/Masters/Import/ --delete --progress
rsync -av /home/daniel/Pictures/Masters/Trips/Hyeres_2024/ /run/media/daniel/CryptStore/Masters/Trips/Hyeres_2024/ --delete --progress
rsync -av /home/daniel/Pictures/Masters/Trips/Namibia_2024/ /run/media/daniel/CryptStore/Masters/Trips/Namibia_2024/ --delete --progress

# mirror CryptStore Masters to DashwoodStore Masters
rsync -avz /run/media/daniel/CryptStore/Masters/ daniel@172.16.3.10:/mnt/storage/DashwoodStore/Photos/Masters/ --delete --progress

# mirror CryptStore Darktable Settings to DashwoodStore Darktable Settings
#rsync -avz /run/media/daniel/CryptStore/Darktable/ daniel@172.16.3.10:/mnt/storage/DashwoodStore/Darktable/ --delete --progress

# mirror Darktable Settings to CryptStore and DashwoodStore
rsync -av /home/daniel/.config/darktable/ /run/media/daniel/CryptStore/Darktable/ --delete --progress
rsync -avz /home/daniel/.config/darktable/ daniel@172.16.3.10:/mnt/storage/DashwoodStore/Darktable/ --delete --progress
