#!/usr/bin/env bash
crystal build --release demo.cr
./demo 1000 1000 20 200 5.0 1 doc/examples/i doc/examples/i/color.config 