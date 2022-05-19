#!/bin/bash

# shellcheck disable=SC2034
# "'pkg_cmd_name' appears unused. Verify it or export it."

function __init_fnm() {
    set -e
    set -u

    ##################
    # Install fnm #
    ##################

    # Every package should define these 6 variables
    pkg_cmd_name="fnm"

    pkg_dst_cmd="$HOME/.local/bin/fnm"
    pkg_dst="$pkg_dst_cmd"

    pkg_src_cmd="$HOME/.local/opt/fnm-v$WEBI_VERSION/bin/fnm"
    pkg_src_dir="$HOME/.local/opt/fnm-v$WEBI_VERSION"
    pkg_src="$pkg_src_cmd"

    # pkg_install must be defined by every package
    pkg_install() {
        # ~/.local/opt/fnm-v0.99.9/bin
        mkdir -p "$(dirname "${pkg_src_cmd}")"

        # mv ./fnm-*/fnm ~/.local/opt/fnm-v0.99.9/bin/fnm
        mv ./fnm-*/fnm "${pkg_src_cmd}"
    }

    # pkg_get_current_version is recommended, but not required
    pkg_get_current_version() {
        # 'fnm --version' has output in this format:
        #       fnm 0.99.9 (rev abcdef0123)
        # This trims it down to just the version number:
        #       0.99.9
        fnm --version 2> /dev/null |
            head -n 1 |
            cut -d ' ' -f 2
    }

}

__init_fnm
