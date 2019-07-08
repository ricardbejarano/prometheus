FROM debian AS build

ARG PROMETHEUS_VERSION="2.10.0"
ARG PROMETHEUS_CHECKSUM="f4233783826f18606b79e5cef0686e4a9c2030146a3c7ce134f0add09f5adcb7"

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
