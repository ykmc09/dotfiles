autoload -U compinit
compinit

autoload colors
colors

PROMPT="%F{blue}%~%k%f> "

alias ll='ls -laFG'
alias vim=mvim
alias dot='cd ~/dev/dotfiles'
