FROM centos:7
MAINTAINER Adrian B. Danieli "https://github.com/sickp"

ENV AUTOCREATE_SERVER_KEYS="RSA ECDSA ED25519"

RUN yum install -y openssh-clients openssh-server && yum -y clean all
RUN echo "root:root" | chpasswd

ADD runner /runner

EXPOSE 22

ENTRYPOINT ["/runner"]

### To disable root password/login:
# RUN usermod -p "!" root

### Create user and set password
# RUN useradd sickp
# RUN echo "sickp:sickp" | chpasswd

### Create user and add an authorized key
# RUN useradd sickp
# ADD https://github.com/sickp.keys /home/sickp/.ssh/authorized_keys
# RUN chown -R sickp:sickp /home/sickp/.ssh/
