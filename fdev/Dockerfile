FROM cgwalters/fdev-base
COPY config-root.sh /root/
COPY config-user.sh /usr/bin
RUN /root/config-root.sh
RUN su - user /usr/bin/config-user.sh
USER user
ENV LANG en_US.UTF-8
ENTRYPOINT ["/usr/bin/tmux", "-l"]
LABEL RUN "docker run --init -ti --security-opt=seccomp:unconfined --security-opt=label:disable -v /srv:/srv:rslave --device /dev/fuse:/dev/fuse --net=host --name \${NAME} --env CONTAINER_NAME=\${NAME} \${IMAGE}"
