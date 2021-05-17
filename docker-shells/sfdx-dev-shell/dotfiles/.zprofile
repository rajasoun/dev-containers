# shell profiling - time
zmodload zsh/zprof

autoload -Uz compinit
if [ $(date +'%j') != $(/usr/bin/stat -f '%Sm' -t '%j' ${ZDOTDIR:-$HOME}/.zcompdump) ]; then
    compinit
else
    compinit -C
fi

## You language environment
export LANG=en_US.UTF-8

## pipx
export PATH=/home/vscode/.local/bin:$PATH

################################################################################################

