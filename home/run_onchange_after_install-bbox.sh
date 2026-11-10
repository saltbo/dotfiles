#!/bin/sh
set -eu

# Shell configuration has not necessarily been loaded by chezmoi.
. "$HOME/.config/shell/path.sh"

# Keep existing installations, including local editable checkouts.
if uv tool list | grep -q '^saltbo-bbox '; then
    exit 0
fi

uv tool install git+https://github.com/saltbo/bbox.git
