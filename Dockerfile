FROM debian AS build

ARG PROMETHEUS_VERSION="2.11.0"
ARG PROMETHEUS_CHECKSUM="9705ee80713809b29995e94ce8786a901c046c9b3fd555aac965bf50a28bc2e3"

ADD https://github.com/prometheus/prometheus/releases/download/v$PROMETHEUS_VERSION/prometheus-$PROMETHEUS_VERSION.linux-amd64.tar.gz /tmp/prometheus.tar.gz

RUN [ "$PROMETHEUS_CHECKSUM" = "$(sha256sum /tmp/prometheus.tar.gz | awk '{print $1}')" ] && \
    tar -C /tmp -xf /tmp/prometheus.tar.gz && \
    mv /tmp/prometheus-$PROMETHEUS_VERSION.linux-amd64 /tmp/prometheus


FROM scratch

COPY --from=build /tmp/prometheus/prometheus.yml \
                  /tmp/prometheus/prometheus \
                  /

COPY --chown=100:100 rootfs /

USER 100:100
VOLUME ["/data"]
EXPOSE 9090/tcp
ENTRYPOINT ["/prometheus"]
