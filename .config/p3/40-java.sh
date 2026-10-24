#!/usr/bin/env sh

# Note: macOS ships a /usr/bin/java stub that exists even with no JDK
# installed, so `has "java"` is not evidence of a runtime. java_home is the
# authority there and exits non-zero when it finds nothing.
if [ "$P3_OS" = "Darwin" ]; then
  if [ -x /usr/libexec/java_home ]; then
    _java_home=$(/usr/libexec/java_home 2>/dev/null)
    [ -n "$_java_home" ] && var "JAVA_HOME" "$_java_home"
    unset _java_home
  fi
elif has "java"; then
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
