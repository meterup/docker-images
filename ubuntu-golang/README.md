# Docker image

We use Ubuntu 18.04 and we want to build images that are compatible with that.
The official Go repository does not offer an Ubuntu flavor. The specific thing
that broke was compiling programs that needed libc. Ubuntu uses 2.27, the Go
Debian image uses 2.28.

We also use envdir to standardize environment variables before loading Go
programs and installing that every time you want to build something is annoying.

The upstream repository is docker-library/golang.

### Binary size

The largest things in the binary are Go (about 347MB unpacked) and Git (about
130MB unpacked). Unfortunately there's not much we can do about either - we need
both and there's not an obvious solution to making either smaller.

### Build

To build and tag `meterup/ubuntu-golang:latest`:

```
make build-latest
```

or whatever Go version we have hardcoded in the Dockerfile:

```
make release
```

You will need to have valid Docker credentials to upload to Docker Hub.

### TODO

Port over the `update.sh` stuff to verify and update the checksums.

## Metrics

As of December 4, 2019 the build takes 4 minutes, 10 seconds.
