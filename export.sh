#!/usr/bin/env bash
set -e
docker run --rm -w /work -v $(PWD):/work taobeier/backslide e -o docs
