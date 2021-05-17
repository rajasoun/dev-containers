#
## Base builder image
##

#FROM alpine:3.13.3 as builder

FROM python:3.9.5-alpine3.13 as python-base-builder

## Install base packages
RUN apk --update add --no-cache --virtual \
    git openssl-dev wget bash bash-completion make jq \
    && mv /etc/profile.d/color_prompt /etc/profile.d/color_prompt.sh \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

## Install Python Packages
RUN set -ex \
    && pip3 --disable-pip-version-check --no-cache-dir install \
        awscli secretcli pipenv pre-commit ggshield pipx\
        --no-warn-script-location \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

## Install Python Packages
RUN set -ex \
    && pip3 --disable-pip-version-check --no-cache-dir install \
        cruft commitizen cumulusci\
        --no-warn-script-location \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

##
## Node.js
##

FROM node:15.10.0-alpine3.13 as nodejs-builder

## Install Node Packages
RUN set -ex \
    && npm install sfdx-cli --global \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

##
## snap shell image
##

FROM python-base-builder
LABEL Vendor="Alpine"
LABEL distro="alpine" distro_version="3.13.0" architecture="x86_64"



# Install Nodejs
COPY --from=nodejs-builder /usr/ /usr/

## System
ENV TIMEZONE="Etc/UTC" \
    TERM="xterm" \
    HOSTNAME="sfdx-dev"

ENV UMASK="0022"
