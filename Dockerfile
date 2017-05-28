FROM ring0club/git:2.13.0-r0
RUN apk add openssh --no-cache
RUN apk add gogs=0.9.97-r1 \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
    --no-cache
# variable USER used by gogs to check for current user(!)
ENV GOGS_CUSTOM=/var/lib/gogs USER=gogs
RUN mkdir $GOGS_CUSTOM/conf && \
    cp /etc/gogs/conf/app.ini $GOGS_CUSTOM/conf/app.ini && \
    chown -R $USER:www-data $GOGS_CUSTOM/conf
VOLUME $GOGS_CUSTOM /var/log/gogs
WORKDIR $GOGS_CUSTOM
USER $USER
EXPOSE 22 3000
ENTRYPOINT ["gogs", "web"]
