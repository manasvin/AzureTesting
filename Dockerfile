FROM alpine:latest
MAINTAINER Me

RUN apk update \
    && apk upgrade \
    && apk add openssh-server openssh-sftp-server 
    
RUN ssh-keygen -A && \
    adduser -h /sftp -s /sbin/nologin -D -u 1000 ${SFTP_USERNAME} sftpuser && \
    chpasswd sftpuser:ftp123

COPY sshd_config /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
 
