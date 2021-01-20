FROM golang:1-alpine AS build

ARG VERSION="2.22.0"
ARG CHECKSUM="9390cbd338d253956184d0f0a6719d21cb5719f0319fc48ee08d5bd48fc87cc2"

ADD https://github.com/prometheus/prometheus/archive/v$VERSION.tar.gz /tmp/prometheus.tar.gz

RUN [ "$CHECKSUM" = "$(sha256sum /tmp/prometheus.tar.gz | awk '{print $1}')" ] && \
    mkdir -p /go/src/github.com/prometheus && \
    tar -C /go/src/github.com/prometheus -xf /tmp/prometheus.tar.gz && \
    apk add ca-certificates curl make nodejs npm && \
    npm install yarn

RUN cd /go/src/github.com/prometheus/prometheus-$VERSION && \
    make build && \
    mkdir -p /rootfs/bin /rootfs/etc/ssl/certs /rootfs/data && \
    cp /go/src/github.com/prometheus/prometheus-$VERSION/prometheus /rootfs/bin/ && \
    cp /go/src/github.com/prometheus/prometheus-$VERSION/documentation/examples/prometheus.yml /rootfs/ && \
    echo "nogroup:*:10000:nobody" > /rootfs/etc/group && \
    echo "nobody:*:10000:10000:::" > /rootfs/etc/passwd && \
    cp /etc/ssl/certs/ca-certificates.crt /rootfs/etc/ssl/certs/


FROM scratch

COPY --from=build --chown=10000:10000 /rootfs /

USER 10000:10000
VOLUME ["/data"]
EXPOSE 9090/tcp
ENTRYPOINT ["/bin/prometheus"]
