#!/bin/bash

mkdir /root/.ssh
echo "$PRIVATE_KEY" > /root/.ssh/id_rsa # works even if key is not rsa kind
chmod 0600 /root/.ssh/id_rsa

if [ -z "${HOST_FINGERPRINT}" ]; then
    echo ">> No public ssh fingerprint found, man-in-the-middle protection disabled!"
    ssh-keyscan -H -p ${PORT} ${HOST} > /root/.ssh/known_hosts
else
    echo ">> Public ssh fingerprint found, man-in-the-middle protection enabled."
    echo "${HOST_FINGERPRINT}" > /root/.ssh/known_hosts
fi

# Execute the command
ssh -o StrictHostKeyChecking=yes "${USER}@${HOST}" -p ${PORT} ${COMMAND}
