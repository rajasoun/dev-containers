#!/usr/bin/env bash

ROOT_DIR="$(git rev-parse --show-toplevel)/tdd/bats"
TDD_BATS_DIR="/code"
DOCKER_CMD="exec docker run -it -v "${ROOT_DIR}:/code" rajasoun/bats-with-helpers:latest"

function run_unit_tests(){
  $DOCKER_CMD ${TDD_BATS_DIR}/test/unit -t  || return 1
}

function run_integration_tests(){
  $DOCKER_CMD ${TDD_BATS_DIR}/test/integration -t  /code/test/integration -t  || return 1
}

function run_all_tests(){
  $DOCKER_CMD ${TDD_BATS_DIR}/test/unit -t  || return 1
  $DOCKER_CMD ${TDD_BATS_DIR}/test/integration -t  || return 1
}

function print_line(){
    echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
}

choice=$1
case $choice in
  unit)
    echo "                                                     Unit Tests                                                 "
    print_line
    run_unit_tests || return 1
    print_line
    ;;
  integration)
    echo "                                                     Integration Tests                                                 "
    print_line
    run_integration_tests || return 1
    print_line
    ;;
  *)
    echo "                                                     All Tests                                                 "
    print_line
    run_all_tests || return 1
    print_line
    ;;
esac
