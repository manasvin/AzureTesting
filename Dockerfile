FROM alpine:latest
MAINTAINER MeUser

ARG SFTP_USERNAME=sftpuser

RUN apk update \
    && apk upgrade \
    && apk add openssh-server openssh-sftp-server \
    && ssh-keygen -A 

COPY sshd_config /etc/ssh/sshd_config
COPY create-sftpuser /usr/local/bin/

RUN create-sftpuser $SFTP_USERNAME

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D","-e"]
