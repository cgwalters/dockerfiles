FROM cgwalters/fdev-base
COPY config-root.sh /root/
COPY config-user.sh /usr/bin
RUN /root/config-root.sh
RUN su - user /usr/bin/config-user.sh
USER user
ENV LANG en_US.UTF-8
ENTRYPOINT ["/usr/bin/tmux", "-l"]
LABEL RUN "docker run -ti --privileged -v /srv:/srv:rslave --net=host --name \${NAME} \${IMAGE}"
