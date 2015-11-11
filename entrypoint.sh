#!/bin/bash

host_key_types="RSA ECDSA ED25519"

# autogenerate host keys if not present
generate_host_key() {
  local key_type=${1}
  local filename="/etc/ssh/ssh_host_${key_type,,}_key"
  if [ ! -f ${filename} ]; then
    /usr/bin/ssh-keygen -q -t ${key_type} -f ${filename} -N ""
    chgrp ssh_keys ${filename}
    chmod 640 ${filename}
    chmod 644 ${filename}.pub
    echo "Generated SSH2 ${key_type} host key."
  fi
}
for key_type in ${host_key_types}; do
  generate_host_key ${key_type}
done

# create utmp to avoid sshd's syslogin_perform_logout warnings
touch /run/utmp
chgrp utmp /run/utmp

# become sshd (-D = do not detach, -e = log to standard error)
exec /usr/sbin/sshd -D -e $@
