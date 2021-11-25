FROM alpine:latest
MAINTAINER Me

RUN apk update \
    && apk upgrade \
    && apk add openssh-server openssh-sftp-server 
    
RUN ssh-keygen -A && \
    adduser -h /sftp -D -s /sbin/nologin sftpuser && \
    echo "sftpuserx:ftp123" | chpasswd

COPY sshd_config /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
 
