# archiva-docker
Vanilla installation of Archiva 2.2 (see [[official stand-alone installation instructions](https://archiva.apache.org/docs/2.2.0/adminguide/standalone.html))

`ARCHIVA_BASE` located at `/var/archiva`. Config and data dirs created if missing, or existing `ARCHIVA_BASE` may be mounted in from the Docker host.

Server listens on `8080`, map to whatever you want on the Docker host.

See DockerHub automated build of this Docker image at [ninjaben/archiva-docker](https://hub.docker.com/r/ninjaben/archiva-docker/).

Example usage:
```
sudo docker run -v ~/existing-archiva-base:/var/archiva -p 8080:8080 -d ninjaben/archiva-docker
```
