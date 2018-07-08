#!/usr/bin/env bash
crystal build --release demo.cr
./demo 800 800 4 40 20.25 1 doc/examples/e/ doc/examples/color.config
