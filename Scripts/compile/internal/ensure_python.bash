#!/bin/bash

set -e

ensure_python_runtime() {
  if command -v python3 >/dev/null 2>&1; then
    export GEN_PYTHON_BIN="$(command -v python3)"
    return 0
  fi

  if command -v python >/dev/null 2>&1; then
    export GEN_PYTHON_BIN="$(command -v python)"
    return 0
  fi

  echo "[INFO] Python runtime not found. Installing python3..."

  local runner=""
  if [ "$(id -u)" -eq 0 ]; then
    runner=""
  elif command -v sudo >/dev/null 2>&1; then
    runner="sudo"
  else
    echo "[ERROR] Python is not installed and sudo is not available."
    return 1
  fi

  if command -v apt-get >/dev/null 2>&1; then
    $runner apt-get update
    $runner apt-get install -y python3
  elif command -v dnf >/dev/null 2>&1; then
    $runner dnf install -y python3
  elif command -v yum >/dev/null 2>&1; then
    $runner yum install -y python3
  elif command -v zypper >/dev/null 2>&1; then
    $runner zypper --non-interactive install python3
  elif command -v pacman >/dev/null 2>&1; then
    $runner pacman -Sy --noconfirm python
  elif command -v apk >/dev/null 2>&1; then
    $runner apk add --no-cache python3
  else
    echo "[ERROR] Unsupported package manager. Please install python3 manually."
    return 1
  fi

  if command -v python3 >/dev/null 2>&1; then
    export GEN_PYTHON_BIN="$(command -v python3)"
    return 0
  fi

  if command -v python >/dev/null 2>&1; then
    export GEN_PYTHON_BIN="$(command -v python)"
    return 0
  fi

  echo "[ERROR] Python installation finished but no python executable was found."
  return 1
}
