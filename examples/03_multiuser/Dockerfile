FROM sickp/centos-sshd:latest
RUN usermod -p "!" root

RUN useradd sickp
ADD https://github.com/sickp.keys /home/sickp/.ssh/authorized_keys
RUN chown -R sickp:sickp /home/sickp/.ssh

RUN useradd afrojas
ADD https://github.com/afrojas.keys /home/afrojas/.ssh/authorized_keys
RUN chown -R afrojas:afrojas /home/afrojas/.ssh
