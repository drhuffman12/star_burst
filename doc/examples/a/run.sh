#!/usr/bin/env bash
crystal build --release doc/examples/demo.cr
doc/examples/demo 100 100 8 12 4.0 1 doc/examples/a/
