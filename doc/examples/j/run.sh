#!/usr/bin/env bash
crystal build --release doc/examples/demo.cr
doc/examples/demo 1000 1000 1 500 1.0 1 doc/examples/j doc/examples/j/color.config 
