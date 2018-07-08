#!/usr/bin/env bash
crystal build --release doc/examples/demo.cr
doc/examples/demo 400 400 1 40 13.5 1 doc/examples/d/ doc/examples/color.config
