FROM debian AS build

ARG PROMETHEUS_VERSION="2.10.0"
ARG PROMETHEUS_CHECKSUM="19d29910fd0e51765d47b59b9276df016441ad4c6c48e3b27e5aa9acb5d1da26"

ADD https://github.com/prometheus/prometheus/releases/download/v$PROMETHEUS_VERSION/prometheus-$PROMETHEUS_VERSION.linux-amd64.tar.gz /tmp/prometheus.tar.gz

RUN cd /tmp && \
    if [ "$PROMETHEUS_CHECKSUM" != "$(sha256sum /tmp/prometheus.tar.gz | awk '{print $1}')" ]; then exit 1; fi && \
    tar xf /tmp/prometheus.tar.gz && \
    mv /tmp/prometheus-$PROMETHEUS_VERSION.linux-amd64 /tmp/prometheus


FROM scratch

COPY --from=build /tmp/prometheus/prometheus /prometheus
COPY --from=build /tmp/prometheus/prometheus.yml /prometheus.yml

STOPSIGNAL SIGTERM

ENTRYPOINT ["/prometheus"]
CMD ["--config.file=/prometheus.yml", "--storage.tsdb.path=/data"]
