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

* [ctags] - Generate ctags automatically when switching branches
* [shellcheck] - Provides a wrapper around Ubuntu's shellcheck
