#!/usr/bin/env sh

# Kubernetes — XDG-aligned paths

var "KUBECONFIG" "${XDG_CONFIG_HOME}/kube/config"
[ ! -d "${XDG_CONFIG_HOME}/kube" ] && mkdir -p "${XDG_CONFIG_HOME}/kube"

var "KUBECACHEDIR" "${XDG_CACHE_HOME}/kube"
[ ! -d "${XDG_CACHE_HOME}/kube" ] && mkdir -p "${XDG_CACHE_HOME}/kube"

# Helm (v3)
var "HELM_DATA_HOME" "${XDG_DATA_HOME}/helm"
[ ! -d "${XDG_DATA_HOME}/helm" ] && mkdir -p "${XDG_DATA_HOME}/helm"

var "HELM_CONFIG_HOME" "${XDG_CONFIG_HOME}/helm"
[ ! -d "${XDG_CONFIG_HOME}/helm" ] && mkdir -p "${XDG_CONFIG_HOME}/helm"

var "HELM_CACHE_HOME" "${XDG_CACHE_HOME}/helm"
[ ! -d "${XDG_CACHE_HOME}/helm" ] && mkdir -p "${XDG_CACHE_HOME}/helm"

# k9s
var "K9S_CONFIG_DIR" "${XDG_CONFIG_HOME}/k9s"
[ ! -d "${XDG_CONFIG_HOME}/k9s" ] && mkdir -p "${XDG_CONFIG_HOME}/k9s"

var "K9S_DATA_DIR" "${XDG_DATA_HOME}/k9s"
[ ! -d "${XDG_DATA_HOME}/k9s" ] && mkdir -p "${XDG_DATA_HOME}/k9s"
