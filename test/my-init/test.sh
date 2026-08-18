#!/usr/bin/env bash

set -euo pipefail

source dev-container-features-test-lib

check "my-init installs successfully" true

reportResults
