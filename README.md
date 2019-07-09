<p align=center><img src=https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/320/apple/198/fire_1f525.png width=120px></p>
<h1 align=center>prometheus (container image)</h1>
<p align=center>The simplest container image of the <a href=https://prometheus.io/>Prometheus monitoring system and time series database</a></p>


## Tags

### Docker Hub

Available on [Docker Hub](https://hub.docker.com) as [`ricardbejarano/prometheus`](https://hub.docker.com/r/ricardbejarano/prometheus):

- [`2.11.0`, `master`, `latest` *(Dockerfile)*](https://github.com/ricardbejarano/prometheus/blob/master/Dockerfile)

### Quay

Available on [Quay](https://quay.io) as [`quay.io/ricardbejarano/prometheus`](https://quay.io/repository/ricardbejarano/prometheus):

- [`2.11.0`, `master`, `latest` *(Dockerfile)*](https://github.com/ricardbejarano/prometheus/blob/master/Dockerfile)


## Features

* Super tiny (`~74.6MB`)
* Binary pulled from official website
* Built `FROM scratch`, see [Filesystem](#filesystem) for an exhaustive list of the image's contents
* Reduced attack surface (no shell, no UNIX tools, no package manager...)


## Configuration

### Volumes

- Bind your **data** at `/data`.
- Bind your **configuration** at `/prometheus.yml`.


## Building

```bash
docker build -t prometheus .
```


## Filesystem

The image's contents are:

```
/
├── prometheus
└── prometheus.yml
```


## License

See [LICENSE](https://github.com/ricardbejarano/prometheus/blob/master/LICENSE).
