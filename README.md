# archiva-docker
Dockerfile for automated DockerHub build of Archiva on Ubuntu

This repository exists to enable automated [DockerHub](https://hub.docker.com/) builds of a Docker image that contains Ubuntu and Archiva.

The Archiva configuration attempts to be faithful to the [official stand-alone installation instructions](https://archiva.apache.org/docs/2.2.0/adminguide/standalone.html), including separation of `ARCHIVA_BASE` from the binary installation.
