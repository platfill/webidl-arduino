#!/bin/bash
set -e

conc() (
  trap 'kill 0' SIGINT SIGTERM ERR EXIT
  for cmd in "$@"; do
    "$SHELL" -c "set -e; $cmd" &
  done
  wait -n
)

rm -rf dist
mkdir -p dist
conc \
  'bikeshed watch src/index.bs dist/index.html' \
  'python -m http.server -d dist'
