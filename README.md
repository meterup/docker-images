# Docker image

We use Ubuntu 18.04 and we want to build images that are compatible with that.
The official Go repository does not offer an Ubuntu flavor. The specific thing
that broke was compiling programs that needed libc. Ubuntu uses 2.27, the Go
Debian image uses 2.28.

We also use envdir to standardize environment variables before loading Go
programs and installing that every time you want to build something is annoying.

### TODO

Port over the `update.sh` stuff to verify and update the checksums.
