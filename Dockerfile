FROM hone/mruby-cli
ENV SHELL /bin/bash
RUN apt-get install -y --no-install-recommends sudo
RUN groupadd -r mruby -g 1000 && \
    useradd -d /home/mruby/ -u 1000 -g mruby -r -s /sbin/nologin -c "Docker image mruby user" mruby && \
    chown -R mruby:mruby /home/mruby/code

ENTRYPOINT ["/home/mruby/code/set-docker-permission.sh"]
