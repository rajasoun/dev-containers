#
## Base builder image
##

FROM bats/bats:latest AS bats-base-builder

FROM alpine/git as bats-helpers
RUN git clone https://github.com/ztombol/bats-support   /bats-test-helpers/bats-support
RUN git clone https://github.com/ztombol/bats-assert    /bats-test-helpers/bats-assert
RUN git clone https://github.com/lox/bats-mock          /bats-test-helpers/lox-bats-mock

FROM python:3.9.5-alpine3.13 as pre-commit
RUN set -ex \
    && pip3 --disable-pip-version-check --no-cache-dir install pre-commit

FROM bats-base-builder
COPY --from=bats-helpers /bats-test-helpers /opt/bats-test-helpers
COPY --from=pre-commit   /usr/local/bin/pre-commit /usr/local/bin/pre-commit
WORKDIR /code/
