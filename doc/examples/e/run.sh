#!/usr/bin/env bash
crystal build --release demo.cr
./demo 800 800 40 60 20.25 1 doc/examples/e/
