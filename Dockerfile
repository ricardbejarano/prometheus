FROM golang:1-alpine AS build

ARG VERSION="2.39.2"
ARG CHECKSUM="b2582a55783d495223b9b0ecf42177c24b9231f298ddca16b9aa04265f53f636"

ADD https://github.com/prometheus/prometheus/archive/v$VERSION.tar.gz /tmp/prometheus.tar.gz

RUN [ "$(sha256sum /tmp/prometheus.tar.gz | awk '{print $1}')" = "$CHECKSUM" ] && \
    apk add bash ca-certificates curl make npm tar yarn && \
    tar -C /tmp -xf /tmp/prometheus.tar.gz && \
    mkdir -p /go/src/github.com/prometheus && \
    mv /tmp/prometheus-$VERSION /go/src/github.com/prometheus/prometheus && \
    cd /go/src/github.com/prometheus/prometheus && \
      make build

RUN mkdir -p /rootfs && \
      cp /go/src/github.com/prometheus/prometheus/documentation/examples/prometheus.yml /rootfs/ && \
    mkdir -p /rootfs/bin && \
      cp /go/src/github.com/prometheus/prometheus/prometheus /rootfs/bin/ && \
    mkdir -p /rootfs/data && \
    mkdir -p /rootfs/etc && \
      echo "nogroup:*:10000:nobody" > /rootfs/etc/group && \
      echo "nobody:*:10000:10000:::" > /rootfs/etc/passwd && \
    mkdir -p /rootfs/etc/ssl/certs && \
      cp /etc/ssl/certs/ca-certificates.crt /rootfs/etc/ssl/certs/


FROM scratch

COPY --from=build --chown=10000:10000 /rootfs /

USER 10000:10000
VOLUME ["/data"]
EXPOSE 9090/tcp
ENTRYPOINT ["/bin/prometheus"]
