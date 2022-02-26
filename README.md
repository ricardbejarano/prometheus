<p align="center"><img src="https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/320/apple/198/fire_1f525.png" width="120px"></p>
<h1 align="center">prometheus (container image)</h1>
<p align="center">Built-from-source container image of the <a href="https://prometheus.io">Prometheus</a> monitoring system and time-series database</p>


## Tags

### Docker Hub

Available on Docker Hub as [`docker.io/ricardbejarano/prometheus`](https://hub.docker.com/r/ricardbejarano/prometheus):

- [`2.33.4`, `latest` *(Dockerfile)*](Dockerfile)

### RedHat Quay

Available on RedHat Quay as [`quay.io/ricardbejarano/prometheus`](https://quay.io/repository/ricardbejarano/prometheus):

- [`2.33.4`, `latest` *(Dockerfile)*](Dockerfile)


## Features

* Compiled from source during build time
* Built `FROM scratch`, with zero bloat
* Statically linked to the [`musl`](https://musl.libc.org/) implementation of the C standard library
* Reduced attack surface (no shell, no UNIX tools, no package manager...)
* Runs as unprivileged (non-`root`) user


## Building

```bash
docker build --tag ricardbejarano/prometheus --file Dockerfile .
```


## Configuration

### Volumes

- Mount your **data** at `/data`.
- Mount your **configuration** at `/prometheus.yml`.


## License

MIT licensed, see [LICENSE](LICENSE) for more details.
