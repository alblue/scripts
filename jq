#!/bin/sh
# ---
# Copyright (c) 2020 Alex Blewitt
#
# Released under the MIT License SPDX:MIT
# See LICENSE.txt for more information
# ---
# Runs jq inside docker on macOS
#
# Usage:
#
#   ./jq

set -euo pipefail

err() {
	echo "$2" > /dev/stderr
	exit "$1"
}

my_name=$(basename "$0")
my_dir=$(dirname "$0")
image="${my_name}":latest

docker=$(command -v docker || true)

# Check that Docker is available and running
[ -n "${docker}" ] || err 1 "Docker not found"
[ -x "${docker}" ] || err 2 "Docker is not executable"
docker version > /dev/null 2> /dev/null || err 3 "Docker is not running"

if tty > /dev/null 2> /dev/null; then
	flags="-it"
else
	flags="-i"
fi

# If we haven't got the docker image available, build or pull it
if ! docker image inspect "${image}" > /dev/null 2> /dev/null; then
	if [ -r "${my_dir}/${my_name}-Dockerfile" ]; then
		docker build "${my_dir}" --rm --file "${my_dir}/${my_name}-Dockerfile" --tag "${image}" > /dev/null 2> /dev/null
	else
		docker pull "${image}"
	fi
fi

docker run --rm "${flags}" --workdir /pwd --volume "$(pwd):/pwd" "${image}" "$@"
