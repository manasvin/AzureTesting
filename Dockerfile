FROM alpine:latest
LABEL OWNER=MeUser

RUN apk update \
    && apk upgrade \
    && apk add openssh-server openssh-sftp-server \
    && rm -rf /var/cache/apk/* \
    && ssh-keygen -A

COPY sshd_config /etc/ssh/sshd_config
COPY entrypoint.sh /

EXPOSE 22

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/sbin/sshd", "-D","-e"]
