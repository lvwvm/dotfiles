#!/usr/bin/env sh

if has "java"; then
  if [ -d /usr/lib/jvm/default ]; then
    var "JAVA_HOME" "/usr/lib/jvm/default"
  fi
fi