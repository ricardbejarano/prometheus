FROM debian AS build

ARG PROMETHEUS_VERSION="2.11.1"
ARG PROMETHEUS_CHECKSUM="50b5f4dfd3f358518c1aaa3bd7df2e90780bdb5292b5c996137c2b1e81102390"

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
