Ctags
=====

The Ubuntu `ctags` program scans a list of source files, and then generates a
`tags` file with keyword-to-file-location mappings. This file can be stored in
`.git/tags` and loaded from editors and IDEs.

Usage
-----

The `ctags-update` script will read in a list of files known to git, and
generate a tags file. This can be run manually, or it can be combined with a
`post-checkout` or `post-commit` workflow.

When triggered from a git hook, the update will be done in the background, as
it may take some time. The tags file is written to a temporary location first,
and then after generation will be replaced.

For this to work on macOS, docker will need to be installed and running, and
the git directory will need to be shared with Docker via the preferences.

Hooks
-----

To install these hooks into a repository, copy or link the `ctags*` scripts
into the .git/hooks directory of your repository.
