#!/usr/bin/env sh

# zsh config
alias zshconfig='vim ~/.zshrc ~/.zprofile ~/.alias.sh'

# Find port 
lsof_port() {
    # exits if command-line parameter absent
    : "${1?"Usage: lsof_port <port_number>"}"
    lsof -nP -iTCP -sTCP:LISTEN | grep "$1"
}

# Quick Utility to view Dockerfile from image
docker_image_history(){
    : "${1?"Usage: docker_image_history <docker_image_id>"}"
    docker history --no-trunc "$1" \
         | tac | tr -s ' ' | cut -d " " -f 5- | \
         sed 's,^/bin/sh -c #(nop) ,,g' | \
         sed 's,^/bin/sh -c,RUN,g' | \
         sed 's, && ,\n  & ,g' | \
         sed 's,\s*[0-9]*[\.]*[0-9]*\s*[kMG]*B\s*$,,g'
}


