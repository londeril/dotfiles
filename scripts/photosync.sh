#!/bin/bash

# mirror CryptStore Masters to BigData Masters
rsync -av /run/media/daniel/CryptStore/Masters/ /mnt/BigData/Photos/Masters/ --delete

# mirror CryptStore Darktable Settings to BigData Darktable Settings 
rsync -av /run/media/daniel/CryptStore/Darktable/ /mnt/BigData/Darktable/ --delete


# mirror CryptStore Masters to DashwoodStore Masters
rsync -av /run/media/daniel/CryptStore/Masters/ /mnt/dashwoodstore/Photos/Masters/ --delete

# mirror CryptStore Darktable Settings to DashwoodStore Darktable Settings 
rsync -av /run/media/daniel/CryptStore/Darktable/ /mnt/dashwoodstore/Darktable/ --delete

