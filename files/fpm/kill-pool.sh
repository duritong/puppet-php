#!/bin/bash

shopt -s nullglob
for fpm in /run/fpm-*/pid; do
  CHILDREN=$(ps -o pid --no-headers --ppid `cat ${fpm}` | wc -l)

  if [ "${CHILDREN}" == "0" ]; then
    kill `cat ${fpm}`
  fi
done
