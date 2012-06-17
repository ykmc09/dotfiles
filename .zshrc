autoload -U compinit
compinit

autoload colors
colors

PROMPT="%F{blue}%~%k%f> "

alias ll='ls -laFG'
alias vim='mvim'
alias dot='cd ~/dev/dotfiles'
alias v='vim'
alias g='git'

export PATH=$PATH:~/dev/play-2.0

