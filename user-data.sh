#!/bin/bash
# A script to automate the deployment of the AddSite CMS Application

# Following line adds a user 'ec2-user' if they are not found. This is only meant for Docker testing.
id -u ec2-user &>/dev/null || adduser -ms /bin/bash ec2-user

# Update the packages, and clean dnf to keep image small.
dnf upgrade -y && \
    dnf install docker && \
    dnf autoremove && \
    dnf clean all;