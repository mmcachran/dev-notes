#!/usr/bin/env bash

###############################################################################
# Strict Mode
#
# More Information:
#   https://github.com/xwmx/bash-boilerplate#bash-strict-mode
#   https://github.com/xwmx/bash-boilerplate?tab=readme-ov-file#simple-strict-mode-tldr
#   http://redsymbol.net/articles/unofficial-bash-strict-mode
#   https://github.com/xwmx/bash-boilerplate#bash-strict-mode
###############################################################################

set -o nounset
set -o errexit
set -o pipefail
set -o noglob
IFS=$'\n\t'

# Detect whether output is piped or not.
[[ -t 1 ]] && piped=0 || piped=1

IFS=$'\n\t'


wp plugin list | \
 awk 'BEGIN{N=0;} \
  ($3=="available"){N++; print $0;} \
  END{print(N>0)?"Plugin updates available: "N:"No plugin updates available";}'
