FROM alpine:latest

#Install squid and clean the cache in the same step

RUN apk add squid && \
    rm -rf /var/cache/apk/* 

COPY entrypoint.sh /

# the proxy port 
EXPOSE 3128/tcp

# Set the enty point
ENTRYPOINT ["/entrypoint.sh"]
