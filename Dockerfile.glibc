FROM golang:1 AS build

ARG VERSION="2.15.2"
ARG CHECKSUM="2ba37bced3e90c5e7dd3248918f13f2f3444de748cfe413b0a09f82532c3c553"

ADD https://github.com/prometheus/prometheus/archive/v$VERSION.tar.gz /tmp/prometheus.tar.gz

RUN [ "$CHECKSUM" = "$(sha256sum /tmp/prometheus.tar.gz | awk '{print $1}')" ] && \
    tar -C /tmp -xf /tmp/prometheus.tar.gz && \
    mkdir -p /go/src/github.com/prometheus && \
    mv /tmp/prometheus-$VERSION /go/src/github.com/prometheus/prometheus

RUN apt update && \
    apt install -y ca-certificates && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt update && \
    apt install -y yarn && \
    cd /go/src/github.com/prometheus/prometheus && \
      make build && \
    echo "nogroup:*:100:nobody" > /tmp/group && \
    echo "nobody:*:100:100:::" > /tmp/passwd && \
    mkdir -p /tmp/data


FROM scratch

COPY --from=build --chown=100:100 /go/src/github.com/prometheus/prometheus/prometheus \
                                  /go/src/github.com/prometheus/prometheus/documentation/examples/prometheus.yml \
                                  /
COPY --from=build --chown=100:100 /tmp/data /data
COPY --from=build --chown=100:100 /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=build --chown=100:100 /tmp/group \
                                  /tmp/passwd \
                                  /etc/

USER 100:100
VOLUME ["/data"]
EXPOSE 9090/tcp
ENTRYPOINT ["/prometheus"]
