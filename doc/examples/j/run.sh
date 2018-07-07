#!/usr/bin/env bash
crystal build --release demo.cr
./demo 1000 1000 1 500 1.0 1 doc/examples/j doc/examples/j/color.config 
