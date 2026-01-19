#!/usr/bin/env bash
set -euo pipefail

t=$(mktemp "/tmp/.emacs-pager.XXXXXXX") || exit 1
cat - > $t
echo 'reading into emacs...'
ec-visual "$t"
rm -f -- $t
