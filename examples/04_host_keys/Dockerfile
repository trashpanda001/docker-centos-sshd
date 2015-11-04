FROM sickp/centos-sshd:latest
RUN \
  usermod -p "!" root && \
  ssh-keygen -q -t RSA -N "" -f /etc/ssh/ssh_host_rsa_key && \
  ssh-keygen -q -t ECDSA -N "" -f /etc/ssh/ssh_host_ecdsa_key && \
  ssh-keygen -q -t ED25519 -N "" -f /etc/ssh/ssh_host_ed25519_key && \
  useradd sickp && \
  mkdir ~sickp/.ssh && \
  curl -o ~sickp/.ssh/authorized_keys https://github.com/sickp.keys
