#!/usr/bin/env bash
crystal build --release doc/examples/demo.cr
doc/examples/demo 1000 1000 10 40 10.0 1 doc/examples/h/ doc/examples/h/color.config 
