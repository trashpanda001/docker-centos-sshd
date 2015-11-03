FROM centos:7
MAINTAINER Adrian B. Danieli "https://github.com/sickp"

RUN \
  yum -y install openssh-clients openssh-server && \
  yum -y clean all && \
  echo "root:root" | chpasswd

ADD runner /runner
EXPOSE 22
ENTRYPOINT ["/runner"]
