#!/usr/bin/env sh

if has "java"; then
  if [ -d /usr/lib/jvm/default ]; then
    var "JAVA_HOME" "/usr/lib/jvm/default"
  fi
fi

if has "gradle" || has "gradlew"; then
  var "GRADLE_USER_HOME" "${XDG_BUILD_HOME}/gradle"
  if [ ! -d $GRADLE_USER_HOME ];then
    mkdir $GRADLE_USER_HOME 
  fi
fi
