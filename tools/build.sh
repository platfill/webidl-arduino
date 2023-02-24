#!/bin/bash
set -e

rsync -a --delete --exclude=*.bs --delete-excluded src/ dist/
bikeshed spec src/index.bs dist/index.html
