@alblue's scripts
=================

The scripts contained in this repository are mainly intended for use on macOS,
by providing utilities that are not otherwise available on an out-of-the-box
install. They either use Bash, Sh or Docker to achieve their goals.

These scripts are provided with no warantee, express or implied, and are
released under the MIT license.

If you clone this repository and add the scripts to your PATH, please be aware
that subsequent updates to this repository may cause (un)intentional changes.
You should review updates and use them at your own risk.

Docker scripts
--------------

* [dimages](dimages) - List images in helpful [drun] format for easy execution
* [dkill](dkill) - Kill the most recent docker container
* [drun](drun) - Run a docker image with sane defaults and supporting ssh; see also [drun-README.md]
* [dstop](dstop) - Stop the most recent docker container

Scripts utilising Docker
------------------------

These scripts use Docker to run an equivalent Ubuntu command, and so will
require that Docker is installed and running in order to use them. Errors will
be reported otherwise.

The associated `command-Dockerfile` contains the definition for building the
docker image locally; these will be used to automatically populate the docker
images on first use.

Git hooks are available for certain commands; `command-pre-commit` can be
symlinked into `.git/hooks/pre-commit` for example.

* [ctags](ctags) - Generate ctags automatically when switching branches
* [jq](jq) - Command-line JSON processor
* [perf](perf) - Allows perf commands to be run under a Docker image
* [shellcheck](shellcheck) - Provides a wrapper around Ubuntu's shellcheck

Git commands
------------

Since you can use `git foo` to run a command `git-foo`, any shell script that
begins with `git-` can extend the functionality of your git environment.

* [git-all](git-all) - Executes the following git command on each subfolder
* [git-browse](git-browse) - Open up the commit in a web browser
