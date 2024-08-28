#!/usr/bin/env bash

SOURCE=${BASH_SOURCE[0]}
while [ -L "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
  SOURCE=$(readlink "$SOURCE")
  [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
SCRIPT_DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )

PWSH_PATH="${PRE_COMMIT_PWSH_PATH:-pwsh}"

if ! command -v "$PWSH_PATH" >/dev/null 2>&1; then
  echo "[ERR] $PWSH_PATH (PowerShell) executable not found"
  exit 1
fi

"$PWSH_PATH" -Command "${SCRIPT_DIR}/PSScriptAnalyzer-wrapper.ps1" "$@"
