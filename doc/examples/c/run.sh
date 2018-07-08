#!/usr/bin/env bash
crystal build --release doc/examples/demo.cr
doc/examples/demo 200 200 5 27 9.0 1 doc/examples/c/
