#!/bin/sh
rclone mount --daemon --vfs-cache-mode full OneDrive: /PATH/TO/MOUNT/POINT
rclone mount --daemon --vfs-cache-mode full OneDrive-ECM: /PATH/TO/MOUNT/POINT
rclone mount --daemon --vfs-cache-mode full Ecmacom: /PATH/TO/MOUNT/POINT
rclone mount --daemon --vfs-cache-mode full Dropbox: /PATH/TO/MOUNT/POINT