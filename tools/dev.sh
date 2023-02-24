#!/bin/bash
set -e

conc() (
  trap 'kill 0' SIGINT SIGTERM ERR EXIT
  for cmd in "$@"; do
    "$SHELL" -c "set -e; $cmd" &
  done
  wait -n
)

rsync -a --delete --exclude=*.bs --delete-excluded src/ dist/
conc \
  'bikeshed watch src/index.bs dist/index.html' \
  'http-server -c-1 dist'
