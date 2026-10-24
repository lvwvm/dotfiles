#!/usr/bin/env sh

if has "openssl"; then
  var "SSL_HOME" "${XDG_DATA_HOME}/ssl"
  [ ! -d "${SSL_HOME}" ] && mkdir -p "${SSL_HOME}"

  var "RANDFILE" "${SSL_HOME}/rand"
  if [ ! -f "${RANDFILE}" ]; then
    openssl rand -out "${RANDFILE}" 32 >/dev/null 2>&1 || :
  fi

  # OPENSSL_CONF is read by *every* OpenSSL-linked binary in the session, not
  # just the openssl in PATH. macOS system tools link against LibreSSL, which
  # understands neither `.include` nor `${ENV::...}` and prints a
  # CRYPTO_internal error on each invocation. Export it only when the openssl
  # that will consume it can actually parse it.
  #
  # Note this is evaluated at login, before mise/zerobrew have extended PATH,
  # so on macOS it is the system LibreSSL that decides -- which is precisely
  # the binary that would break.
  case "$(openssl version 2>/dev/null)" in
    LibreSSL*) ;;
    *)
      var "OPENSSL_CONF" "${XDG_CONFIG_HOME}/openssl/openssl.cnf"
      [ ! -d "$(dirname "${OPENSSL_CONF}")" ] && mkdir -p "$(dirname "${OPENSSL_CONF}")"
      ;;
  esac
fi
