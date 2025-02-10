#!/bin/bash
# This script mimics the user-data / bootstrap script that can be put into the configuration of EC2 servers.

set -e

# Update the packages, and clean dnf to keep image small.
dnf upgrade -y && \
    dnf install -y docker git && \
    dnf autoremove && \
    dnf clean all;

# Finally, execute the main command.
exec "$@"
