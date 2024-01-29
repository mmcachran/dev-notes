#!/usr/bin/env bash
set -Eeuo pipefail
IFS=$'\n\t'

export LC_ALL=C

# General variables.
readonly WORK_DIR=$(dirname "$(readlink --canonicalize-existing "${0}" 2> /dev/null)")


WEBSITE_URLS=(
    "https://www.highpoint.edu/familyweekend/event/nido-and-mariana-qubein-childrens-museum-tours-3/"
    "https://www.google.com/"
)

for url in "${WEBSITE_URLS[@]}"; do
    if curl -s --head --request GET ${url} | grep "200 OK" > /dev/null; then
        continue
    fi

    echo "URL is returning a 404:  ${url}"

    echo "Flushing permalinks..."
    wp rewrite flush --url=${url} --path=/var/www/wordpress/
done
