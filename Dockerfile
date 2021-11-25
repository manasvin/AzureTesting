FROM alpine:latest
MAINTAINER MeUser

RUN apk update \
    && apk upgrade \
    && apk add openssh-server openssh-sftp-server 
    
RUN ssh-keygen -A && \
    adduser -D -s /sbin/nologin sftpuser && \
    echo "sftpuser:ftp123" | chpasswd && \
    chown -R root:root /home/sftpuser && \
    chmod 755 /home/sftpuser 

COPY sshd_config /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D","-d"]
