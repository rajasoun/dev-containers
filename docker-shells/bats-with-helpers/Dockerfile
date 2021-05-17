#
## Base builder image
##

FROM bats/bats:latest AS bats-base-builder

FROM alpine/git as bats-helpers
RUN git clone https://github.com/ztombol/bats-support   /bats-test-helpers/bats-support
RUN git clone https://github.com/ztombol/bats-assert    /bats-test-helpers/bats-assert
RUN git clone https://github.com/lox/bats-mock          /bats-test-helpers/lox-bats-mock

FROM bats-base-builder
COPY --from=bats-helpers /bats-test-helpers /opt/bats-test-helpers
WORKDIR /code/

