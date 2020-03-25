<p align="center"><img src="https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/320/apple/198/fire_1f525.png" width="120px"></p>
<h1 align="center">prometheus (container image)</h1>
<p align="center">Built-from-source container image of the <a href="https://prometheus.io">Prometheus monitoring system and time-series database</a></p>


## Tags

### Docker Hub

Available on [Docker Hub](https://hub.docker.com) as [`ricardbejarano/prometheus`](https://hub.docker.com/r/ricardbejarano/prometheus):

- [`2.16.0-glibc`, `2.16.0`, `glibc`, `master`, `latest` *(Dockerfile.glibc)*](https://github.com/ricardbejarano/prometheus/blob/master/Dockerfile.glibc) (about `80.3MB`)
- [`2.16.0-musl`, `musl` *(Dockerfile.musl)*](https://github.com/ricardbejarano/prometheus/blob/master/Dockerfile.musl) (about `80.3MB`)

### Quay

Available on [Quay](https://quay.io) as:

- [`quay.io/ricardbejarano/prometheus`](https://quay.io/repository/ricardbejarano/prometheus), [`quay.io/ricardbejarano/prometheus-glibc`](https://quay.io/repository/ricardbejarano/prometheus-glibc), tags: [`2.16.0`, `master`, `latest` *(Dockerfile.glibc)*](https://github.com/ricardbejarano/prometheus/blob/master/Dockerfile.glibc) (about `80.3MB`)
- [`quay.io/ricardbejarano/prometheus-musl`](https://quay.io/repository/ricardbejarano/prometheus-musl), tags: [`2.16.0`, `master`, `latest` *(Dockerfile.musl)*](https://github.com/ricardbejarano/prometheus/blob/master/Dockerfile.musl) (about `80.3MB`)


## Features

* Super tiny (see [Tags](#tags))
* Compiled from source during build time
* Built `FROM scratch`, with zero bloat (see [Filesystem](#filesystem))
* Reduced attack surface (no shell, no UNIX tools, no package manager...)
* Runs as unprivileged (non-`root`) user


## Building

- To build the `glibc`-based image: `$ docker build -t prometheus:glibc -f Dockerfile.glibc .`
- To build the `musl`-based image: `$ docker build -t prometheus:musl -f Dockerfile.musl .`


## Configuration

### Volumes

- Mount your **data** at `/data`.
- Mount your **configuration** at `/prometheus.yml`.


## Filesystem

```
/
├── data/
├── etc/
│   ├── group
│   ├── passwd
│   └── ssl/
│       └── certs/
│           └── ca-certificates.crt
├── prometheus
└── prometheus.yml
```


## License

See [LICENSE](https://github.com/ricardbejarano/prometheus/blob/master/LICENSE).
