#!/usr/bin/env bash
crystal build --release doc/examples/demo.cr
doc/examples/demo 800 800 4 40 20.25 1 doc/examples/e/ doc/examples/color.config
