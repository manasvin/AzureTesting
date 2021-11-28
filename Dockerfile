FROM alpine:latest
MAINTAINER MeUser

ARG SFTP_USERNAME=sftpuser

RUN apk update \
    && apk upgrade \
    && apk add openssh-server openssh-sftp-server \
    && ssh-keygen -A 

COPY sshd_config /etc/ssh/sshd_config
COPY entrypoint.sh /

EXPOSE 22

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/sbin/sshd", "-D","-e"]
