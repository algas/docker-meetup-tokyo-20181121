#!/usr/bin/env bash
docker run --rm -w /work -v $(PWD):/work taobeier/backslide e -o docs
