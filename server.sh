#!/usr/bin/env bash
docker run --rm --name backslide -w /work -v $(PWD):/work -p 4100:4100 -d taobeier/backslide s
