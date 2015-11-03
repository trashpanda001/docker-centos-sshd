FROM sickp/centos-sshd:latest
RUN usermod -p "!" root
ADD ~/.ssh/identity.pub /root/.ssh/authorized_keys
