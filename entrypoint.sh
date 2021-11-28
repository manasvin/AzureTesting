

if [ -z "${SFTP_USERNAME}" ]; then
  echo "Need username as argument ..."
  exit 1
fi

providedusername="${SFTP_USERNAME}"

adduser -D -s /sbin/nologin $providedusername
echo "$providedusername:ftp123" | chpasswd
#chown -R root:root "/home/$providedusername"
#chmod 755 /home/sftpuser 

cd /home/$providedusername 
ln -s datafeed/folder1 folder1 
ln -s datafeed/folder2 folder2

userKeysQueuedDir="/home/$user/.ssh/keys"
if [ -d "$userKeysQueuedDir" ]; then
    userKeysAllowedFileTmp="$(mktemp)"
    userKeysAllowedFile="/home/$user/.ssh/authorized_keys"

    for publickey in "$userKeysQueuedDir"/*; do
        cat "$publickey" >> "$userKeysAllowedFile"
    done

    chown "$uid" "$userKeysAllowedFile"
    chmod 600 "$userKeysAllowedFile"
fi


exec "$@"
