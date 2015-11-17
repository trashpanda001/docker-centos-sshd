### CentOS SSHD

A simple, [dockerized OpenSSH service][centos_sshd] built on top of the [official CentOS][centos] Docker image.

The root password is "root".

Auto-generates SSH host keys (RSA, DSA, ECDSA, and ED25519) when the container is started, unless already present.

#### Basic usage

```sh
$ docker run -dP --name=sshd sickp/centos-sshd
7b7579858c25bf07b48d6442bf4d346a140b86d0405809af9efde14ba4377d2a

$ docker logs sshd
ssh-keygen: generating new host keys: RSA1 RSA DSA ECDSA ED25519
Server listening on 0.0.0.0 port 22.
Server listening on :: port 22.

$ docker port sshd
22/tcp -> 0.0.0.0:32768

$ ssh root@localhost -p 32768 # on Mac/Windows replace localhost with $(docker-machine ip default)
# The root password is "root".
```

Any additional arguments are passed to `sshd`. For example, to enable debug output:

```sh
$ docker run -dP --name=sshd sickp/centos-sshd -o LogLevel=DEBUG
```

#### Supported tags and `Dockerfile` links

* `7`, `latest` ([versions/7/Dockerfile][dockerfile_7])

#### Customization through extension

This image doesn't attempt to be "the one" solution that suits everyone's needs. It's actually pretty useless in the real world. But it is easy to extend via your own `Dockerfile`. See the [examples][examples] directory.

##### Change root password

Change the root password to something more fun, like "password" or "sunshine":

```dockerfile
FROM sickp/centos-sshd:latest
RUN echo "root:sunshine" | chpasswd
```

##### Use authorized keys

Disable the root password completely, and use your SSH key instead:

```dockerfile
FROM sickp/centos-sshd:latest
RUN usermod -p "!" root
COPY identity.pub /root/.ssh/authorized_keys
```

##### Create multiple users

Disable root and create individual user accounts:

```dockerfile
FROM sickp/centos-sshd:latest
RUN \
  usermod -p "!" root && \
  useradd sickp && \
  mkdir ~sickp/.ssh && \
  curl -o ~sickp/.ssh/authorized_keys https://github.com/sickp.keys && \
  useradd afrojas && \
  mkdir ~afrojas/.ssh && \
  curl -o ~afrojas/.ssh/authorized_keys https://github.com/afrojas.keys
```

##### Embed SSH host keys

Embed SSH host keys directly in your private image, so you can treat your containers like cattle.

```dockerfile
FROM sickp/centos-sshd:latest
RUN \
  usermod -p "!" root && \
  ssh-keygen -A && \
  useradd sickp && \
  mkdir ~sickp/.ssh && \
  curl -o ~sickp/.ssh/authorized_keys https://github.com/sickp.keys
```

#### History

- 2015-11-16 Simplified entrypoint and host key generation. Reorganized.
- 2015-11-11 Allow passing of arguments to SSHD.
- 2015-11-03 Collapse layers, setuid ping, .dockerignore, more examples.
- 2015-11-02 Initial version.

[centos_sshd]:  https://hub.docker.com/r/sickp/centos-sshd/
[centos]:       https://hub.docker.com/_/centos/
[dockerfile_7]: https://github.com/sickp/docker-centos-sshd/tree/master/versions/7/Dockerfile
[examples]:     https://github.com/sickp/docker-centos-sshd/tree/master/examples/
