#!/usr/bin/env bash
set -e
cp -r resource docs/
docker run --rm -w /work -v $(PWD):/work taobeier/backslide e -o docs
