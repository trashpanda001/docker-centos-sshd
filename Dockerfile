FROM centos:7
MAINTAINER Adrian B. Danieli "https://github.com/sickp"

ENV AUTOCREATE_SERVER_KEYS="RSA ECDSA ED25519"

RUN yum install -y openssh-clients openssh-server && yum -y clean all
RUN echo "root:root" | chpasswd

ADD runner /runner

EXPOSE 22

ENTRYPOINT ["/runner"]
