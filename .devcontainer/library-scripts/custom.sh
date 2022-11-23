#!/usr/bin/env bash

set -e 

echo -e "Running further customizations..."

# Generate new SSH key silently (empty PW!)
< /dev/zero ssh-keygen -q -N ""

echo -e "Done!"