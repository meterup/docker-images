# bin directory

The bin directory has to be structured this way (with subdirectories for each
image) since Docker looks at every file in the COPY operation for changes. So if
they are all in the same directory and any one of them changes, Docker won't use
the image cache.

Also ensure that you are only COPY'ing the subdirectory and not the root, e.g.

```
COPY bin/git /tmp/gitbin
RUN /tmp/gitbin/install-deps
```

instead of `COPY bin, RUN /tmp/bin/git/install-deps` etc.
