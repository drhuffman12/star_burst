#!/usr/bin/env bash
crystal build --release demo.cr
./demo 400 400 1 40 13.5 1 doc/examples/d/ doc/examples/color.config
