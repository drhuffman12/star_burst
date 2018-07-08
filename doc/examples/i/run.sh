#!/usr/bin/env bash
crystal build --release doc/examples/demo.cr
doc/examples/demo 1000 1000 1 200 10.0 1 doc/examples/i doc/examples/i/color.config 
