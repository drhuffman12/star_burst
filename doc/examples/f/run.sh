#!/usr/bin/env bash
crystal build --release demo.cr
./demo 800 800 20 40 10 1 doc/examples/f/
