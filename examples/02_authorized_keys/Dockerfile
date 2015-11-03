FROM sickp/centos-sshd:latest
RUN usermod -p "!" root
COPY identity.pub /root/.ssh/authorized_keys
