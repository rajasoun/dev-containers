source ~/.alias.sh

###################################################################
# Either Prezto or oh-my-zsh can be used

# Prezto — Instantly Awesome Zsh
# setopt EXTENDED_GLOB
# unsetopt correct
# unsetopt correctall
# DISABLE_CORRECTION="true"

# source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

# oh-my-zsh 
export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME="robbyrussell"


plugins=(git)
source $ZSH/oh-my-zsh.sh
alias ohmyzsh="vim ~/.oh-my-zsh"
###################################################################




