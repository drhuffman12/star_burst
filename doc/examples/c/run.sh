#!/usr/bin/env bash
crystal build --release demo.cr
./demo 200 200 18 27 9.0 1 doc/examples/c/
