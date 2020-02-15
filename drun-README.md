drun
====

The drun command is an abbreviation of `docker run`, which allows executing
docker images with some sane defaults.

Usage
-----

The `drun` command takes an image name and (optionally) a command to run:

```sh
$ drun ubuntu:20.04 bash
```

Additional docker options can be passed through to the launch if desired:

```sh
$ drun --publish 8080:8080 ubuntu:20.04 bash
```

Options
-------

The working directory is mounted read-only as `/pwd` in the Docker image.
A different mount can be specified, or it can be mounted as read-only by
setting the following variables prior to the launch:

```sh
$ DOCKER_WORKDIR=/pwd drun ubuntu:20.04 pwd # default
/pwd
$ DOCKER_WORKDIR=/work drun ubuntu:20.04 pwd
/work
$ DOCKER_MOUNT=ro drun ubuntu:20.04 touch typing # default
touch: cannot touch 'typing': Read-only file system
$ DOCKER_MOUNT=rw drun ubuntu:20.04 touch typing
```

By default, the docker container will be run as `root` but this can be
overridden with a variable at launch:

```sh
$ DOCKER_USER=root drun ubuntu:20.04 whoami # default
root
$ DOCKER_USER=nobody drun ubuntu:20.04 whoami
nobody
```

Notes
-----

 * Running with `--rm` ensures that the container is temporary, and that the
   contents are not kept between runs (but importantly, so that it doesn't take
   up additional space that would require running `docker system prune`
   occasionally to clean up.

 * Running with `--interactive --ttty` ensures that we have an interactive
   terminal, which is useful for runing interactive programs such as
   [shellcheck] or [ctags].

 * The `--publish-all` flag publishes all ports specified in the Dockerfile, in
   case there are default ports which should be published; it is a no-op if
   there are no
   [`EXPOSE`](https://docs.docker.com/engine/reference/builder/#expose)
   statments in the docker file.

 * SSH credentials are picked up by mounting `~/.ssh` into the container, along
   with exporting `SSH_AUTH_SOCK` if present. On macOS, the ability to mount
   a socket path isn't supported, so Docker has a workaround where the socket
   is exposed at `/run/host-services/ssh-auth.sock` instead.
