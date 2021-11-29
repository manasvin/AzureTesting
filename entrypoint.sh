#!/bin/sh


if [ -z "${SFTP_USERNAME}" ]; then
    providedusername="sftpuser"
else
    providedusername="${SFTP_USERNAME}"
    echo "User $providedusername"
fi

if [ -z "${TARGET_FEEDFOLDER}" ]; then
    targetfeedfldr="datafeed"
else
    targetfeedfldr="${TARGET_FEEDFOLDER}"
    echo "Target Folders:${TARGET_FEEDFOLDER}"
fi

linkedfolders=""
if ! [ -z "${LINKED_FOLDERS}" ]; then
    linkedfolders="${LINKED_FOLDERS}"
    echo "Linked Folders:${LINKED_FOLDERS}"
fi

adduser -h /home/$providedusername -D -s /sbin/nologin $providedusername
echo "$providedusername:ftp123" | chpasswd
chown -R root:root "/home/$providedusername"
chmod 755 "/home/$providedusername"

cd /home/$providedusername
ln -s datafeed/folder1 folder1
ln -s datafeed/folder2 folder2

userKeysQueuedDir="/home/$providedusername/.ssh/keys"

if [ -d "$userKeysQueuedDir" ]; then

    userKeysAllowedFile="/home/$providedusername/.ssh/authorized_keys"

    for publickey in "$userKeysQueuedDir"/*; do
        cat "$publickey" >> "$userKeysAllowedFile"
    done

    chown "$providedusername" "$userKeysAllowedFile"
    chmod 600 "$userKeysAllowedFile"
fi

exec "$@"
