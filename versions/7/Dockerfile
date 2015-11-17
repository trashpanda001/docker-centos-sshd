# CentOS 7.x, OpenSSH_6.6.1p1, OpenSSL 1.0.1e-fips 11 Feb 2013

FROM centos:7
MAINTAINER Adrian B. Danieli "https://github.com/sickp"

RUN \
  yum -y install openssh-clients openssh-server && \
  yum -y clean all && \
  touch /run/utmp && \
  chmod u+s /usr/bin/ping && \
  echo "root:root" | chpasswd

COPY entrypoint.sh /

EXPOSE 22
ENTRYPOINT ["/entrypoint.sh"]
