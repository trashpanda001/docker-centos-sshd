FROM sickp/centos-sshd:latest
RUN \
  usermod -p "!" root && \
  ssh-keygen -A && \
  useradd sickp && \
  mkdir ~sickp/.ssh && \
  curl -o ~sickp/.ssh/authorized_keys https://github.com/sickp.keys
