#!/usr/bin/env bash
crystal build --release doc/examples/demo.cr
doc/examples/demo 800 800 20 40 10 1 doc/examples/f/
