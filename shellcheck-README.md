Shellcheck
==========

Shellcheck looks for common mistakes in scripts and gives feedback to make them
more portable, less error prone, or better.  Documentation for each of the
suggestions are available at https://github.com/koalaman/shellcheck/wiki

Usage
-----

`shellcheck` checks one or more scripts passed on the command line, or via stdin.

Docker needs to be running, and if scripts are passed on the command line, the
directory needs to be available through Docker preferences. Passing the script
contents in via stdin does not require sharing the folder.

```sh Example
$ cat > example.sh
#!/bin/sh

echo I've failed shellcheck because ${REASONS}

$ shellcheck example.sh

In example.sh line 3:
echo This script has ${PROBLEMS}
                     ^-- SC2086: Double quote to prevent globbing and word splitting.

```

Notes
-----

Running the script will create and tag a docker image `shellcheck:latest` if it
does not exist. A similar container can be created by executing the
`shellcheck-Dockerfile` script, after making it executable.

Alternatively, the docker image may be hosted elsewhere and the script modified
to use a pull instead of a build step.

Pre-commit hook
---------------

To run shellcheck automatically on a git repository when you perform a commit,
add (or link) the `shellcheck-pre-commit` scriptinto `.git/hooks/pre-commit` in
the repository you are using, along with the `shellcheck` script.
