# About the Project

Container environment for bash script TDD

## Getting Started

### In Visual Studio Code with Remote Container Support

1. Open project in visual studio code with [remote container extension installed](SLS.md#quick-background)
1.  Open Foledr in Remote Container
1. `assist.bash` for building and releasing docker

## TDD

1. `tdd/bats/ci.sh` for TDD framework for bash script depends on [bats helpers dockerfile](docker-shells/bats-with-helpers/Dockerfile)

1. Explore [Bats Test](tdd/bats/test/unit/test_unit_os.bats) example
