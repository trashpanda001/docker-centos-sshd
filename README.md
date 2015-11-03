# CentOS SSHD

This is a simple, dockerized SSH service built on top of the [official CentOS 7](https://hub.docker.com/_/centos/) Docker image.

The root password is "root".

By default, SSH2 host keys (RSA, ECDSA, and ED25519) are generated when the container is started, if not already present.

## Basic usage

```bash
$ docker run -dP --name=sshd sickp/centos-sshd
7b7579858c25bf07b48d6442bf4d346a140b86d0405809af9efde14ba4377d2a

$ docker logs sshd
Generated SSH2 RSA host key.
Generated SSH2 ECDSA host key.
Generated SSH2 ED25519 host key.
Server listening on 0.0.0.0 port 22.
Server listening on :: port 22.

$ docker port sshd
22/tcp -> 0.0.0.0:32768

$ ssh root@localhost -p 32768 # or $(docker-machine ip default) on Mac OS X / Windows
# The root password is "root".
```

## Customization through extension

This image doesn't attempt to be "the one" solution that suits everyone's needs. It's actually pretty useless in the real world. But it is easy to extend via your own `Dockerfile`.

### Change the root password to something more fun, like "password" or "sunshine"

```dockerfile
FROM sickp/centos-sshd:latest
RUN echo "root:sunshine" | chpasswd
```

### Disable the root password completely, and use your SSH key instead

```dockerfile
FROM sickp/centos-sshd:latest
RUN usermod -p "!" root
COPY identity.pub /root/.ssh/authorized_keys
```

### Disable root and create individual user accounts

```dockerfile
FROM sickp/centos-sshd:latest
RUN usermod -p "!" root

RUN useradd sickp
ADD https://github.com/sickp.keys /home/sickp/.ssh/authorized_keys
RUN chown -R sickp:sickp /home/sickp/.ssh

RUN useradd afrojas
ADD https://github.com/afrojas.keys /home/afrojas/.ssh/authorized_keys
RUN chown -R afrojas:afrojas /home/afrojas/.ssh
```
