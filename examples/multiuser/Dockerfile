FROM sickp/centos-sshd:latest
RUN \
  usermod -p "!" root && \
  useradd sickp && \
  mkdir ~sickp/.ssh && \
  curl -o ~sickp/.ssh/authorized_keys https://github.com/sickp.keys && \
  useradd afrojas && \
  mkdir ~afrojas/.ssh && \
  curl -o ~afrojas/.ssh/authorized_keys https://github.com/afrojas.keys
